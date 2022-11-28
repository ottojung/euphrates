;;;; Copyright (C) 2020, 2021, 2022  Otto Jung
;;;;
;;;; This program is free software; you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; version 3 of the License.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

%run guile

%var profun-create-database
%var profun-eval-query
%var profun-iterate
%var profun-next

%use (comp) "./comp.scm"
%use (define-type9) "./define-type9.scm"
%use (fn-cons) "./fn-cons.scm"
%use (fn-pair) "./fn-pair.scm"
%use (hashmap->alist) "./hashmap.scm"
%use (profun-CR-what profun-CR?) "./profun-CR.scm"
%use (make-profun-IDR profun-IDR?) "./profun-IDR.scm"
%use (profun-RFC-modify-iter profun-RFC?) "./profun-RFC.scm"
%use (profun-abort-set-iter profun-abort?) "./profun-abort.scm"
%use (profun-accept-alist profun-accept-ctx profun-accept-ctx-changed? profun-accept?) "./profun-accept.scm"
%use (make-profun-database profun-database-add-rule! profun-database-get profun-database-handle profun-database?) "./profun-database.scm"
%use (make-profun-env profun-env-get profun-env-set!) "./profun-env.scm"
%use (make-profun-error profun-error-args profun-error?) "./profun-error.scm"
%use (profun-instruction-args profun-instruction-arity profun-instruction-build profun-instruction-constructor profun-instruction-context profun-instruction-next profun-instruction-sign) "./profun-instruction.scm"
%use (profun-iterator-constructor profun-iterator-copy profun-iterator-db profun-iterator-env profun-iterator-query profun-iterator-state set-profun-iterator-state!) "./profun-iterator.scm"
%use (profun-op-procedure) "./profun-op-obj.scm"
%use (profun-query-handle-underscores) "./profun-query-handle-underscores.scm"
%use (profun-reject?) "./profun-reject.scm"
%use (profun-rule-args profun-rule-body profun-rule-index profun-rule-name) "./profun-rule.scm"
%use (profun-state-build profun-state-constructor profun-state-current profun-state-failstate profun-state-final? profun-state-finish profun-state-stack profun-state-undo profun-state? set-profun-state-current) "./profun-state.scm"
%use (profun-bound-value? profun-make-var profun-value-unwrap) "./profun-value.scm"
%use (profun-varname?) "./profun-varname-q.scm"
%use (raisu) "./raisu.scm"
%use (make-usymbol) "./usymbol.scm"

(define-type9 <set-var-command>
  (make-set-var-command name value) set-var-command?
  (name set-var-command-name)
  (value set-var-command-value)
  )

;; returns profun-instruction or #f
(define (get-alternative-instruction db s)
  (define inst (profun-state-current s))
  (cond
   ((profun-instruction-context inst) inst)
   ((procedure? (profun-instruction-sign inst)) #f)
   (else
    (let* ((sign (profun-instruction-sign inst))
           (arity (profun-instruction-arity inst))
           (get-from-pair (lambda (p a)
                            (let* ((name (car p))
                                   (ver  (cdr p))
                                   (new  (cons name (+ ver 1)))
                                   (get  (profun-database-get db new a)))
                              get)))
           (rule
            (cond
             ((pair? sign) (get-from-pair sign arity))
             (else (get-from-pair (cons sign 0) arity)))))

      (and rule
           (profun-instruction-constructor
            (cons (profun-rule-name rule)
                  (profun-rule-index rule))
            (profun-instruction-args inst)
            (profun-instruction-arity inst)
            (profun-instruction-next inst)
            (profun-instruction-context inst)))))))

(define (make-unique-varname symb rule)
  (make-usymbol symb rule))

(define alpha-reduce
  (let ((counter 0))
    (lambda (rule args)
      (define r-args (profun-rule-args rule))

      (define (repl symb)
        (cond
         ((pair? symb) symb)
         ((not (profun-varname? symb)) symb)
         (else
          (let lp ((rbuf r-args)
                   (abuf args))
            (if (null? rbuf)
                (make-unique-varname symb counter)
                (if (equal? symb (car rbuf))
                    (car abuf)
                    (lp (cdr rbuf) (cdr abuf))))))))

      (define (app-pair body)
        (map
         (lambda (x)
           (cons
            (car x)
            (map repl (cdr x))))
         body))

      (set! counter (+ 1 counter))
      (app-pair (profun-rule-body rule)))))

;; uses alpha, then builds the alpha body,
;; and returns first instruction
(define (beta-reduce rule args)
  (profun-instruction-build (alpha-reduce rule args)))

(define (enter-subroutine s ;; state
                          instruction
                          target-rule)
  (define replaced
    (beta-reduce target-rule (profun-instruction-args instruction)))

  (define new-state
    (profun-state-constructor
     replaced
     (cons instruction (profun-state-stack s))
     s ;; failstate
     '()
     ))

  new-state)

(define (profun-instruction-set-ctx inst new-ctx)
  (profun-instruction-constructor
   (profun-instruction-sign inst)
   (profun-instruction-args inst)
   (profun-instruction-arity inst)
   (profun-instruction-next inst)
   new-ctx))

(define (init-foreign-instruction inst target-rule)
  (profun-instruction-constructor
   (cons (profun-instruction-sign inst) (profun-rule-body target-rule)) ;; sign
   (profun-instruction-args inst)
   (profun-instruction-arity inst)
   (profun-instruction-next inst)
   #f ;; ctx
   ))

(define (handle-accept-change s0 env instruction args ret)
  (define new-context (profun-accept-ctx ret))
  (define new-failstate
    (if (profun-accept-ctx-changed? ret)
        (set-profun-state-current
         s0 (profun-instruction-set-ctx instruction new-context))
        s0))

  (define alist/vars
    (profun-accept-alist ret))

  (define new-undo-list
    (map
     (fn-pair
      (name value)
      (define wrapped (profun-make-var name value))
      (define old (profun-env-get env name))
      (define undo-command (make-set-var-command name old))
      (when (profun-bound-value? old)
        (raisu 'operation-rebinds-a-bound-variable name old))
      (profun-env-set! env name wrapped)
      undo-command)
     alist/vars))

  (continue
   (profun-state-constructor
    instruction
    (profun-state-stack s0)
    new-failstate
    new-undo-list
    )))

(define (handle-accept env s instruction args ret)
  (if (and (not (profun-accept-ctx-changed? ret))
           (null? (profun-accept-alist ret)))
      (continue s)
      (handle-accept-change s env instruction args ret)))

(define (handle-abort db env s ret)
  ret)

(define (enter-foreign db env s instruction)
  (define sign (profun-instruction-sign instruction))
  (define handler (cdr sign))
  (define func (profun-op-procedure handler))
  (define context (profun-instruction-context instruction))
  (define args (profun-instruction-args instruction))
  (define get-func (comp (profun-env-get env)))
  (define ret (func get-func context args))

  (cond
   ((profun-accept? ret)
    (handle-accept env s instruction args ret))
   ((profun-reject? ret)
    (backtrack db env s))
   ((profun-abort? ret)
    (handle-abort db env s ret))
   (else
    (raisu 'bad-type-of-object-returned-from-foreign ret))))

;; takes a state, makes step forward, returns new state
(define (continue s)
  (define current (profun-state-current s))
  (define next (profun-instruction-next current))

  (if next
      (set-profun-state-current s next)
      (if (null? (profun-state-stack s))
          (profun-state-finish s)
          (continue
           (set-profun-state-current
            s
            (car (profun-state-stack s))
            (cdr (profun-state-stack s)))))))

(define (apply-instruction db env s)
  (define instruction (profun-state-current s))
  (define key (profun-instruction-sign instruction))
  (define arity (profun-instruction-arity instruction))
  (define target-rule (profun-database-get db key arity))

  (if target-rule
      (enter-subroutine s instruction target-rule)
      (if (profun-instruction-context instruction)
          (enter-foreign db env s instruction)
          (let ((target-rule (profun-database-handle db key arity)))
            (if target-rule
                (enter-foreign db env s (init-foreign-instruction instruction target-rule))
                (make-profun-IDR key arity))))))

(define (run-undos env s)
  (for-each
   (lambda (undo-command)
     (cond
      ((set-var-command? undo-command)
       (profun-env-set!
        env
        (set-var-command-name undo-command)
        (set-var-command-value undo-command)))
      (else
       (raisu 'unknown-undo-command undo-command))))
   (profun-state-undo s)))

(define (backtrack db env initial-state)
  (run-undos env initial-state)
  (let lp ((s (profun-state-failstate initial-state)))
    (if (not s) 'backtracking-full-stop
        (let ((alt (get-alternative-instruction db s)))
          (case alt
            ((#f)
             (run-undos env s)
             (lp (profun-state-failstate s)))
            (else (set-profun-state-current s alt)))))))

(define (eval-state db env initial-state)
  (let loop ((initial-state initial-state))
    (define new-state
      (apply-instruction db env initial-state))

    (cond
     ((or (not (profun-state? new-state)) (profun-state-final? new-state)) new-state)
     (else (loop new-state)))))

;; accepts list of rules that looks like:
;; '(((abc x) (= x 2))
;;   ((yyy x) (abc x))
;;   ((abc x) (= x 3))
;;   )
;; returns profun-database
(define (profun-create-database botom-handler lst-of-rules)
  (define db (make-profun-database botom-handler))
  (for-each (comp (profun-database-add-rule! db)) lst-of-rules)
  db)

(define (profun-next iter)
  (define db (profun-iterator-db iter))
  (define env (profun-iterator-env iter))
  (define query (profun-iterator-query iter))
  (define last-state (profun-iterator-state iter))

  (define (backtrack-eval db env s)
    (let ((b (backtrack db env s)))
      (if (equal? 'backtracking-full-stop b) b
          (eval-state db env b))))
  (define (take-vars s)
    (hashmap->alist env))

  (define (initialize-state query)
    (define query/usymboled (profun-query-handle-underscores query))
    (if (symbol? query/usymboled)
        (make-profun-error query/usymboled)
        (profun-state-build query/usymboled)))

  (define (cont current-state new-state)
    (cond
     ((equal? 'backtracking-full-stop new-state)
      (set-profun-iterator-state!
       iter (profun-state-finish current-state))
      #f)
     ((profun-state? new-state)
      (set-profun-iterator-state! iter new-state)
      (map (fn-cons identity profun-value-unwrap)
           (filter (lambda (x) (symbol? (car x)))
                   (take-vars new-state))))
     ((profun-abort? new-state)
      (let ()
        (define new0
          (if (equal? #f last-state)
              (profun-state-finish current-state)
              (backtrack-eval db env last-state)))
        (define new
          (if (equal? 'backtracking-full-stop new0)
              (profun-state-finish current-state)
              new0))
        (define ret
          (let ((iter-copy (profun-iterator-copy iter)))
            (set-profun-iterator-state! iter-copy current-state)
            (profun-abort-set-iter
             new-state iter-copy)))
        (set-profun-iterator-state! iter new)
        ret))

     (else (raisu 'unknown-profun-state-type-in-profun-run new-state))))

  (define (eval-cont/goodstate current-state)
    (define new (eval-state db env current-state))
    (cont current-state new))

  (define (eval-cont current-state)
    (if (equal? 'backtracking-full-stop current-state) #f
        (eval-cont/goodstate current-state)))

  (cond
   ((equal? #f last-state)
    (let ((s0 (initialize-state query)))
      (if (profun-state? s0)
          (eval-cont/goodstate s0)
          s0)))
   ((profun-state-final? last-state)
    (eval-cont (backtrack db env last-state)))
   (else
    (eval-cont/goodstate last-state))))

(define (profun-iterate/g db env state query)
  (profun-iterator-constructor db env state query))

;; accepts profun-database `db` and list of symbols `query`
;; returns an iterator
(define (profun-iterate db query)
  (cond
   ((not (profun-database? db))
    (make-profun-error 'not-a-profun-database db))
   (else
    (let ((env (make-profun-env))
          (state #f))
      (profun-iterate/g db env state query)))))

(define (profun-eval-from iterator start)
  (let loop ((buf start))
    (let ((r (profun-next iterator)))
      (cond
       ((or (pair? r) (null? r)) (loop (cons r buf)))
       ((equal? #f r) (reverse! buf))
       ((profun-IDR? r) (loop buf))
       ((profun-CR? r)
        (raisu 'profun-returned-custom-value (profun-CR-what r)))
       ((profun-error? r)
        (raisu 'profun-errored (profun-error-args r)))
       ((profun-RFC? r)
        (let ((mod (profun-RFC-modify-iter
                    r
                    (lambda (new-iter) (profun-eval-from new-iter buf)))))
          (raisu 'profun-needs-more-info mod)))
       (else (raisu 'unknown-result-type-in-profun-query r))))))

;; accepts profun-database `db` and list of symbols `query`
;; returns a list of result alists
(define (profun-eval-query db query)
  (define iterator (profun-iterate db query))
  (profun-eval-from iterator '()))
