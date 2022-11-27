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

%var profun-database?
%var profun-create-database
%var profun-database-add-rule!
%var profun-database-copy
%var profun-eval-query
%var profun-make-iterator
%var profun-next
%var profun-iterator-copy
%var profun-iterator-db
%var profun-iterator-insert!
%var profun-iterator-reset!

%use (comp) "./comp.scm"
%use (define-type9) "./define-type9.scm"
%use (fn-cons) "./fn-cons.scm"
%use (fn-pair) "./fn-pair.scm"
%use (hashmap->alist hashmap-copy hashmap-delete! hashmap-ref hashmap-set! make-hashmap) "./hashmap.scm"
%use (list-and-map) "./list-and-map.scm"
%use (list-ref-or) "./list-ref-or.scm"
%use (profun-CR-what profun-CR?) "./profun-CR.scm"
%use (make-profun-IDR profun-IDR?) "./profun-IDR.scm"
%use (profun-RFC-modify-continuation profun-RFC?) "./profun-RFC.scm"
%use (profun-abort-set-continuation profun-abort?) "./profun-abort.scm"
%use (profun-accept-alist profun-accept-ctx profun-accept-ctx-changed? profun-accept?) "./profun-accept.scm"
%use (make-profun-error profun-error-args profun-error?) "./profun-error.scm"
%use (profun-instruction-args profun-instruction-arity profun-instruction-constructor profun-instruction-context profun-instruction-next profun-instruction-sign) "./profun-instruction.scm"
%use (profun-op-procedure) "./profun-op-obj.scm"
%use (profun-reject?) "./profun-reject.scm"
%use (profun-rule-args profun-rule-body profun-rule-constructor profun-rule-index profun-rule-name) "./profun-rule.scm"
%use (profun-bound-value? profun-make-constant profun-make-unbound-var profun-make-var profun-value-unwrap) "./profun-value.scm"
%use (profun-varname?) "./profun-varname-q.scm"
%use (raisu) "./raisu.scm"
%use (make-usymbol) "./usymbol.scm"

(define-type9 <profun-database>
  (profun-database-constructor table handler) profun-database?
  (table profun-database-table)
  (handler profun-database-handler)
  )

(define-type9 <profun-state>
  (profun-state-constructor current stack failstate undo) profun-state?
  (current profun-state-current) ;; current `profun-instruction`
  (stack profun-state-stack) ;; list of `profun-instruction`s
  (failstate profun-state-failstate) ;; `state` to go to if this `state` fails. Initially #f
  (undo profun-state-undo) ;; commands to run when backtracking to `failstate'. Initially '()
  )

(define-type9 <profun-iterator>
  (profun-iterator-constructor db env state query) profun-iterator?
  (db profun-iterator-db)
  (env profun-iterator-env)
  (state profun-iterator-state set-profun-iterator-state!)
  (query profun-iterator-query set-profun-iterator-query!)
  )

(define-type9 <set-var-command>
  (make-set-var-command name value) set-var-command?
  (name set-var-command-name)
  (value set-var-command-value)
  )

(define (make-state start-instruction)
  (profun-state-constructor
   start-instruction
   (list) ;; stack
   #f ;; failstate
   '()
   ))

(define set-profun-state-current
  (case-lambda
   ((s instruction)
    (set-profun-state-current s instruction (profun-state-stack s)))
   ((s instruction stack)
    (profun-state-constructor
     instruction
     stack
     (profun-state-failstate s)
     (profun-state-undo s)
     ))))

(define (profun-state-final? s)
  (not (profun-state-current s)))
(define (profun-state-finish s)
  (set-profun-state-current s #f))

(define (profun-iterator-copy iter)
  (define db (profun-iterator-db iter))
  (define env (profun-iterator-env iter))
  (define new-db (profun-database-copy db))
  (define new-env (env-copy env))
  (define state (profun-iterator-state iter))
  (define query (profun-iterator-query iter))
  (profun-iterator-constructor new-db new-env state query))

(define (profun-iterator-insert! iter instruction-prefix)
  (define db (profun-iterator-db iter))
  (define state (profun-iterator-state iter))
  (define new-state
    (add-prefix-to-instruction db state instruction-prefix))
  (set-profun-iterator-state! iter new-state))

(define (profun-iterator-reset! iter new-query)
  (define new-state (build-state new-query))
  (set-profun-iterator-state! iter new-state)
  (set-profun-iterator-query! iter new-query))

(define (make-profun-database botom-handler)
  (profun-database-constructor (make-hashmap) botom-handler))

(define (profun-database-copy db)
  (profun-database-constructor
   (hashmap-copy (profun-database-table db))
   (profun-database-handler db)))

(define (profun-database-handle db key arity)
  (let ((function ((profun-database-handler db) key arity)))
    (and function (profun-rule-constructor key 0 (list) function))))

(define (double-hashmap-ref H key1 key2)
  (define h (hashmap-ref H key1 #f))
  (and h (hashmap-ref h key2 #f)))

(define (double-hashmap-set! H key1 key2 value)
  (define h0 (hashmap-ref H key1 #f))
  (define h
    (or h0 (begin (let ((h (make-hashmap)))
                    (hashmap-set! H key1 h) h))))
  (hashmap-set! h key2 value))

(define (profun-database-get db k arity)
  (define (get db key index arity)
    (let ((r (double-hashmap-ref (profun-database-table db) key arity)))
      (and r (list-ref-or r index #f))))

  (if (pair? k)
      (get db (car k) (cdr k) arity)
      (get db k 0 arity)))

(define (profun-database-add! db name args body)
  (let* ((arity (length args))
         (table (profun-database-table db))
         (existing (or (double-hashmap-ref table name arity) '()))
         (index (length existing))
         (value (profun-rule-constructor name index args body)))

    (double-hashmap-set!
     (profun-database-table db)
     name arity
     (append existing (list value)))))

(define (make-env)
  (make-hashmap))
(define (env-get env key)
  (if (profun-varname? key)
      (hashmap-ref env key (profun-make-unbound-var key))
      (profun-make-constant key)))
(define (env-set! env key value)
  (if (profun-bound-value? value)
      (hashmap-set! env key value)
      (hashmap-delete! env key)))
(define (env-unset! env key)
  (hashmap-delete! env key))
(define (env-copy env)
  (hashmap-copy env))

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
  (build-body (alpha-reduce rule args)))

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
      (define old (env-get env name))
      (define undo-command (make-set-var-command name old))
      (when (profun-bound-value? old)
        (raisu 'operation-rebinds-a-bound-variable name old))
      (env-set! env name wrapped)
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

(define (get-current-subroutine s)
  (define stack (profun-state-stack s))
  (if (null? stack)
      (values #f #f)
      (let ()
        (define instruction (car stack))
        (define key (profun-instruction-sign instruction))
        (define arity (profun-instruction-arity instruction))
        (values key arity))))

(define (add-prefix-to-instruction db s instruction-prefix)
  (define-values (key arity) (get-current-subroutine s))
  (define current (profun-state-current s))
  (define table (profun-database-table db))
  (define rules (or (double-hashmap-ref table key arity) '()))
  (define (add-to-rule rule)
    ;; FIXME: add not at a begining of a rule,
    ;;        but before current instruction.
    (define body (profun-rule-body rule))
    (define new-body (append instruction-prefix body))
    (profun-rule-constructor
     (profun-rule-name rule)
     (profun-rule-index rule)
     (profun-rule-args rule)
     new-body))
  (define new-rules
    (if (list? rules)
        (map add-to-rule rules)
        (add-to-rule rules)))
  (define new-current
    (build-body/next instruction-prefix current))

  (double-hashmap-set! table key arity new-rules)

  (set-profun-state-current s new-current))

(define (build-state query)
  (define new-current (build-body query))
  (make-state new-current))

(define (handle-abort db env s ret)
  ret)

(define (enter-foreign db env s instruction)
  (define sign (profun-instruction-sign instruction))
  (define handler (cdr sign))
  (define func (profun-op-procedure handler))
  (define context (profun-instruction-context instruction))
  (define args (profun-instruction-args instruction))
  (define get-func (comp (env-get env)))
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
       (env-set! env
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

(define (build-body/next body next)
  (define rev (reverse body))

  (define (make-one block next)
    (define sign (car block))
    (define args (cdr block))
    (profun-instruction-constructor
     sign args (length args) next #f))

  (define result
    (let lp ((buf rev) (prev next))
      (if (null? buf)
          prev
          (let ((current (make-one (car buf) prev)))
            (lp (cdr buf) current)))))

  result)

;; accepts list of symbols "body"
;; and returns first instruction
(define (build-body body)
  (build-body/next body #f))

(define (profun-database-add-rule! db r)
  (define first (car r))
  (define name (car first))
  (define args-init (cdr first))
  (define body-init (cdr r))

  (define (ret args body-app)
    (let ((body (append body-app body-init)))
      (profun-database-add! db name args body)))

  (let lp ((buf args-init)
           (i 0)
           (aret (list))
           (bret-app (list)))
    (if (null? buf)
        (ret (reverse aret) (reverse bret-app))
        (let ((x (car buf)))
          (if (not (profun-varname? x))
              (let ((u (make-usymbol name `(arg ,i))))
                (lp (cdr buf)
                    (+ i 1)
                    (cons u aret)
                    (cons `(= ,u ,x) bret-app))) ;; NOTE: relies on =/2 to be provided by handler
              (lp (cdr buf)
                  (+ i 1)
                  (cons x aret)
                  bret-app))))))

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
    (define query/usymboled (query-handle-underscores query))
    (if (symbol? query/usymboled)
        (make-profun-error query/usymboled)
        (build-state query/usymboled)))

  (define (continuation iter-c)
    (lambda (continue? db-additions instruction-prefix)
      (define new-iter (profun-iterator-copy iter-c))
      (define new-db (profun-iterator-db new-iter))
      (for-each (comp (profun-database-add-rule! new-db)) db-additions)
      (if continue?
          (profun-iterator-insert! new-iter instruction-prefix)
          (profun-iterator-reset! new-iter instruction-prefix))
      new-iter))

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
          (let ((iter-c (profun-iterator-copy iter)))
            (set-profun-iterator-state! iter-c current-state)
            (profun-abort-set-continuation
             new-state (continuation iter-c))))
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

(define (profun-make-iterator/g db env state query)
  (profun-iterator-constructor db env state query))

(define (query-handle-underscores query)
  (define (handle-elem x)
    (if (symbol? x)
        (let ((s (symbol->string x)))
          (if (string-prefix? "_" s)
              (if (= 1 (string-length s))
                  (make-usymbol x (gensym))
                  (make-usymbol x 'u))
              x))
        x))

  (define (handle-expr expr)
    (map handle-elem expr))

  (cond
   ((not (list? query)) 'bad-query:not-a-list)
   ((not (list-and-map list? query)) 'bad-query:expr-not-a-list)
   (else (map handle-expr query))))

;; accepts profun-database `db` and list of symbols `query`
;; returns an iterator
(define (profun-make-iterator db query)
  (cond
   ((not (profun-database? db))
    (make-profun-error 'not-a-profun-database db))
   (else
    (let ((env (make-env))
          (state #f))
      (profun-make-iterator/g db env state query)))))

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
        (let ((mod (profun-RFC-modify-continuation
                    r
                    (lambda (new-iter) (profun-eval-from new-iter buf)))))
          (raisu 'profun-needs-more-info mod)))
       (else (raisu 'unknown-result-type-in-profun-query r))))))

;; accepts profun-database `db` and list of symbols `query`
;; returns a list of result alists
(define (profun-eval-query db query)
  (define iterator (profun-make-iterator db query))
  (profun-eval-from iterator '()))
