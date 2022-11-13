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
%var profun-run-query

%use (comp) "./comp.scm"
%use (define-type9) "./define-type9.scm"
%use (fn-cons) "./fn-cons.scm"
%use (fn-pair) "./fn-pair.scm"
%use (hashmap) "./hashmap.scm"
%use (hashmap->alist hashmap-copy hashmap-delete! hashmap-ref hashmap-set!) "./ihashmap.scm"
%use (list-ref-or) "./list-ref-or.scm"
%use (make-profun-IDR profun-IDR?) "./profun-IDR.scm"
%use (profun-RFC profun-RFC-what profun-RFC?) "./profun-RFC.scm"
%use (profun-accept-alist profun-accept-ctx profun-accept-ctx-changed? profun-accept?) "./profun-accept.scm"
%use (profun-op-procedure) "./profun-op-obj.scm"
%use (profun-reject?) "./profun-reject.scm"
%use (profun-make-constant profun-make-unbound-var profun-make-var profun-value-unwrap) "./profun-value.scm"
%use (profun-varname?) "./profun-varname-q.scm"
%use (raisu) "./raisu.scm"
%use (stack) "./stack-obj.scm"
%use (usymbol usymbol?) "./usymbol.scm"

(define-type9 <database>
  (database a b) database?
  (a database-table)
  (b database-handler)
  )

(define-type9 <rule>
  (rule-constructor a b c d) rule?
  (a rule-name) ;; : symbol
  (b rule-index) ;; : number (together with "name" gives a unique index)
  (c rule-args) ;; : list of symbols
  (d rule-body) ;; : list of lists of symbols
  )

(define-type9 <instruction>
  (instruction-constructor a b c d e) instruction?
  (a instruction-sign) ;; operation signature, like name and version for alternative
  (b instruction-args) ;; arguments
  (c instruction-arity) ;; arity
  (d instruction-next) ;; link to next `instruction`, or #f is this is the last one
  (e instruction-context) ;; : #f | any
  )

(define-type9 <state>
  (state a b c d) state?
  (a state-current) ;; current `instruction`
  (b state-stack) ;; list of `instruction`s
  (c state-env) ;; hashmap of `variable`s
  (d state-failstate) ;; `state` to go to if this `state` fails. Initially #f
  )

(define (make-state start-instruction)
  (state start-instruction
         (list) ;; stack
         (make-env) ;; env
         #f ;; failstate
         ))

(define (state-final? s)
  (not (and (state? s) (state-current s))))
(define (state-finish s)
  (state #f
         (state-stack s)
         (state-env s)
         (state-failstate s)))

(define (make-database botom-handler)
  (database (hashmap) botom-handler))

(define (database-handle db key arity)
  (let ((function ((database-handler db) key arity)))
    (and function (rule-constructor key 0 (list) function))))

(define (double-hashmap-ref H key1 key2)
  (define h (hashmap-ref H key1 #f))
  (and h (hashmap-ref h key2 #f)))

(define (double-hashmap-set! H key1 key2 value)
  (define h0 (hashmap-ref H key1 #f))
  (define h
    (or h0 (begin (let ((h (hashmap)))
                    (hashmap-set! H key1 h) h))))
  (hashmap-set! h key2 value))

(define (database-get db k arity)
  (define (get db key index arity)
    (let ((r (double-hashmap-ref (database-table db) key arity)))
      (and r (list-ref-or r index #f))))

  (if (pair? k)
      (get db (car k) (cdr k) arity)
      (get db k 0 arity)))

(define (database-add! db name args body)
  (let* ((arity (length args))
         (table (database-table db))
         (existing (or (double-hashmap-ref table name arity) '()))
         (index (length existing))
         (value (rule-constructor name index args body)))

    (double-hashmap-set!
     (database-table db)
     name arity
     (append existing (list value)))))

(define (make-env)
  (hashmap))
(define (env-get env key)
  (if (profun-varname? key)
      (hashmap-ref env key (profun-make-unbound-var key))
      (profun-make-constant key)))
(define (env-set! env key value)
  (hashmap-set! env key value))
(define (env-unset! env key)
  (hashmap-delete! env key))
(define (env-copy env)
  (hashmap-copy env))

;; returns instruction or #f
(define (get-alternative-instruction db s)
  (define inst (state-current s))
  (cond
   ((instruction-context inst) inst)
   ((procedure? (instruction-sign inst)) #f)
   (else
    (let* ((sign (instruction-sign inst))
           (arity (instruction-arity inst))
           (get-from-pair (lambda (p a)
                            (let* ((name (car p))
                                   (ver  (cdr p))
                                   (new  (cons name (+ ver 1)))
                                   (get  (database-get db new a)))
                              get)))
           (rule
            (cond
             ((pair? sign) (get-from-pair sign arity))
             (else (get-from-pair (cons sign 0) arity)))))

      (and rule
           (instruction-constructor
            (cons (rule-name rule)
                  (rule-index rule))
            (instruction-args inst)
            (instruction-arity inst)
            (instruction-next inst)
            (instruction-context inst)))))))

(define (make-unique-varname symb rule)
  (usymbol symb rule))

;; TODO: garbage-collect redundant variables?
(define alpha-reduce
  (let ((counter 0))
    (lambda (rule args)
      (define r-args (rule-args rule))

      (define (repl symb)
        (cond
         ((pair? symb)
          (cons (repl (car symb))
                (repl (cdr symb))))
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
      (app-pair (rule-body rule)))))

;; uses alpha, then builds the alpha body,
;; and returns first instruction
(define (beta-reduce rule args)
  (build-body (alpha-reduce rule args)))

(define (enter-subroutine s ;; state
                          instruction
                          target-rule)
  (define replaced
    (beta-reduce target-rule (instruction-args instruction)))

  (define new-state
    (state replaced
           (cons instruction (state-stack s))
           (state-env s)
           s)) ;; failstate

  new-state)

(define (instruction-set-ctx inst new-ctx)
  (instruction-constructor
   (instruction-sign inst)
   (instruction-args inst)
   (instruction-arity inst)
   (instruction-next inst)
   new-ctx))

(define (init-foreign-instruction inst target-rule)
  (instruction-constructor
   (rule-body target-rule) ;; sign
   (instruction-args inst)
   (instruction-arity inst)
   (instruction-next inst)
   #f ;; ctx
   ))

(define (handle-accept-change s env instruction args ret)
  (define new-context (profun-accept-ctx ret))
  (define new-failstate
    (if (profun-accept-ctx-changed? ret)
        (construct-from-alt
         s (instruction-set-ctx instruction new-context))
        (state-failstate s)))

  (define alist/vars
    (profun-accept-alist ret))

  (define new-env
    (if (null? alist/vars) env
        (env-copy env)))

  (for-each
   (fn-pair
    (name value)
    (define wrapped (profun-make-var name value))
    (env-set! new-env name wrapped))
   alist/vars)

  (continue
   (state instruction
          (state-stack s)
          new-env
          new-failstate)))

(define (handle-accept s env instruction args ret)
  (if (and (not (profun-accept-ctx-changed? ret))
           (null? (profun-accept-alist ret)))
      (continue s)
      (handle-accept-change s env instruction args ret)))

(define (get-current-subroutine s)
  (define stack (state-stack s))
  (if (null? stack)
      (values #f #f)
      (let ()
        (define instruction (car stack))
        (define key (instruction-sign instruction))
        (define arity (instruction-arity instruction))
        (values key arity))))

(define (add-prefix-to-instruction db s instruction-prefix)
  (define-values (key arity) (get-current-subroutine s))
  (define current (state-current s))
  (define table (database-table db))
  (define rules (or (double-hashmap-ref table key arity) '()))
  (define (add-to-rule rule)
    (define body (rule-body rule))
    (define new-body (append instruction-prefix body))
    (rule-constructor
     (rule-name rule)
     (rule-index rule)
     (rule-args rule)
     new-body))
  (define new-rules
    (if (list? rules)
        (map add-to-rule rules)
        (add-to-rule rules)))
  (define new-current
    (build-body/next instruction-prefix current))

  (double-hashmap-set! table key arity new-rules)

  (state new-current
         (state-stack s)
         (state-env s)
         (state-failstate s)))

(define (handle-RFC db s ret)
  (define what (profun-RFC-what ret))
  (define continuation
    (lambda (db-additions instruction-prefix)
      (define new-db (database-copy db))
      (define new-s (add-prefix-to-instruction new-db s instruction-prefix))
      (for-each (comp (database-add-rule! new-db)) db-additions)
      (profun-run new-db new-s)))

  (profun-RFC continuation what))

(define (enter-foreign db s instruction)
  (define env (state-env s))
  (define handler (instruction-sign instruction))
  (define func (profun-op-procedure handler))
  (define context (instruction-context instruction))
  (define args (instruction-args instruction))
  (define argv (map (comp (env-get env)) args))
  (define ret (func argv context))

  (cond
   ((profun-reject? ret)
    (backtrack db s))
   ((profun-accept? ret)
    (handle-accept s env instruction args ret))
   ((profun-RFC? ret)
    (handle-RFC db s ret))
   (else
    (raisu 'bad-type-of-object-returned-from-foreign ret))))

;; takes a state, makes step forward, returns new state
(define (continue s)
  (define current (state-current s))
  (define next (instruction-next current))

  (if next
      (state next
             (state-stack s)
             (state-env s)
             (state-failstate s))
      (if (null? (state-stack s))
          (state-finish s)
          (continue
           (state (car (state-stack s))
                  (cdr (state-stack s))
                  (state-env s)
                  (state-failstate s))))))

(define (apply-instruction db s)
  (define instruction (state-current s))
  (define key (instruction-sign instruction))
  (define arity (instruction-arity instruction))
  (define target-rule (database-get db key arity))

  (if target-rule
      (enter-subroutine s instruction target-rule)
      (if (instruction-context instruction)
          (enter-foreign db s instruction)
          (let ((target-rule (database-handle db key arity)))
            (if target-rule
                (enter-foreign db s (init-foreign-instruction instruction target-rule))
                (make-profun-IDR key arity))))))

(define (construct-from-alt s alt)
  (state alt
         (state-stack s)
         (state-env s)
         (state-failstate s)))

(define (backtrack db initial-state)
  (let lp ((s (state-failstate initial-state)))
    (if (not s) #f
        (let ((alt (get-alternative-instruction db s)))
          (case alt
            ((#f) (lp (state-failstate s)))
            ((builtin) s)
            (else (construct-from-alt s alt)))))))

(define (eval-state db initial-state)
  (define new-state
    (apply-instruction db initial-state))

  (if (state-final? new-state)
      new-state
      (eval-state db new-state)))

(define (build-body/next body next)
  (define rev (reverse body))

  (define (make-one block next)
    (define sign (car block))
    (define args (cdr block))
    (instruction-constructor
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

(define (database-copy db)
  (database
   (hashmap-copy (database-table db))
   (database-handler db)))

(define (database-add-rule! db r)
  (define first (car r))
  (define name (car first))
  (define args-init (cdr first))
  (define body-init (cdr r))

  (define (ret args body-app)
    (let ((body (append body-app body-init)))
      (database-add! db name args body)))

  (let lp ((buf args-init)
           (i 0)
           (aret (list))
           (bret-app (list)))
    (if (null? buf)
        (ret (reverse aret) (reverse bret-app))
        (let ((x (car buf)))
          (if (not (profun-varname? x))
              (let ((u (usymbol name `(arg ,i))))
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
;; returns database
(define (profun-create-database botom-handler lst-of-rules)
  (define db (make-database botom-handler))
  (for-each (comp (database-add-rule! db)) lst-of-rules)
  db)

(define (profun-run db initial-state)
  (define (backtrack-eval db s)
    (let ((b (backtrack db s)))
      (and b (eval-state db b))))
  (define (take-vars s)
    (hashmap->alist (state-env s)))

  (define current-state #t)

  (define (ret-this last-state)
    (define copy current-state)
    (set! current-state
          (if (equal? #t last-state) #f
              (backtrack-eval db last-state)))
    copy)

  (lambda _
    (define last-state current-state)
    (case current-state
      ((#t)
       (set! current-state (eval-state db initial-state)))
      ((#f) #f)
      (else
       (set! current-state (backtrack-eval db current-state))))

    (cond
     ((state? current-state)
      ;; TODO: optimize by using hashmap-foreach.
      (map (fn-cons identity profun-value-unwrap)
           (filter (lambda (x) (not (usymbol? (car x))))
                   (take-vars current-state))))

     ((equal? #f current-state) #f)

     ((profun-RFC? current-state)
      (ret-this last-state))

     ((profun-IDR? current-state)
      (ret-this last-state))

     (else (raisu 'unknown-state-type-in-profun-run current-state)))))

;; accepts database `db` and list of symbols `query`
;; returns an iterator
(define (profun-run-query db query)
  (define start-instruction (build-body query))
  (define initial-state (make-state start-instruction))
  (profun-run db initial-state))

;; accepts database `db` and list of symbols `query`
;; returns a list of result alists
(define (profun-eval-query db query)
  (define iterator (profun-run-query db query))
  (let loop ()
    (let ((r (iterator)))
      (cond
       ((or (pair? r) (null? r)) (cons r (loop)))
       ((equal? #f r) '())
       ((profun-IDR? r) (loop))
       ((profun-RFC? r) (raisu 'profun-needs-more-info (profun-RFC-what r)))
       (else (raisu 'unknown-result-type-in-profun-query r))))))
