;;;; Copyright (C) 2020, 2021  Otto Jung
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

%var create-database
%var eval-query

%use (define-type9) "./define-type9.scm"
%use (hashmap) "./hashmap.scm"
%use (hashmap-ref hashmap-set! hashmap-copy hashmap->alist) "./ihashmap.scm"
%use (usymbol usymbol?) "./usymbol.scm"
%use (profun-varname?) "./profun-varname-q.scm"
%use (list-ref-or) "./list-ref-or.scm"

(define-type9 <database>
  (database a b) database?
  (a database-table)
  (b database-handler)
  )

(define-type9 <rule>
  (rule a b c d) rule?
  (a rule-name) ;; : symbol
  (b rule-index) ;; : number (together with "name" gives a unique index)
  (c rule-args) ;; : list of symbols
  (d rule-body) ;; : list of lists of symbols
  )

(define-type9 <instruction>
  (instruction a b c d e) instruction?
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
  (not (and s (state-current s))))
(define (state-finish s)
  (state #f
         (state-stack s)
         (state-env s)
         (state-failstate s)))

(define (make-database botom-handler)
  (database (hashmap) botom-handler))

(define (database-handle db key arity)
  (let ((function ((database-handler db) key arity)))
    (and function (rule key 0 (list) function))))

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

(define (database-set! db name args body)
  (let* ((arity (length args))
         (existing (or (double-hashmap-ref (database-table db) name arity) '()))
         (index (length existing))
         (value (rule name index args body)))

    (double-hashmap-set!
     (database-table db)
     name arity
     (append existing (list value)))))

(define (make-env)
  (hashmap))
(define (env-get env key)
  (if (profun-varname? key)
      (hashmap-ref env key #f)
      key))
(define (env-set env key value)
  (let ((copy (hashmap-copy env)))
    (hashmap-set! copy key value)
    copy))

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
           (instruction
            (cons (rule-name rule)
                  (rule-index rule))
            (instruction-args inst)
            (instruction-arity inst)
            (instruction-next inst)
            (instruction-context inst)))))))

(define (make-unique-varname symb rule)
  (usymbol symb rule))

(define (alpha-reduce rule args)
  (define r-args (rule-args rule))

  (define (repl symb)
    (if (not (profun-varname? symb)) symb
        (let lp ((rbuf r-args)
                 (abuf args))
          (if (null? rbuf)
              (make-unique-varname symb rule)
              (if (equal? symb (car rbuf))
                  (car abuf)
                  (lp (cdr rbuf) (cdr abuf)))))))

  (define (app-pair body)
    (map
     (lambda (x)
       (cons
        (car x)
        (map repl (cdr x))))
     body))

  (app-pair (rule-body rule)))

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
  (instruction (instruction-sign inst)
               (instruction-args inst)
               (instruction-arity inst)
               (instruction-next inst)
               new-ctx))

(define (init-foreign-instruction inst target-rule)
  (instruction (rule-body target-rule) ;; sign
               (instruction-args inst)
               (instruction-arity inst)
               (instruction-next inst)
               #f)) ;; ctx

(define (enter-foreign db s instruction)
  (define env (state-env s))
  (define func (instruction-sign instruction))
  (define context (instruction-context instruction))
  (define args (instruction-args instruction))
  (define argv (map (lambda (a) (env-get env a)) args))
  (define ret-all (func argv context))
  (if (eq? #t ret-all) (continue s)
      (let ((ret (and ret-all (car ret-all)))
            (ctx (and ret-all (cdr ret-all))))
        (if (not ret) (backtrack db s)
            (continue
             (let* ((m (if (eq? ret #t) '() (map cons args ret)))
                    (new-env
                     (let loop ((e env) (buf m))
                       (if (null? buf) e
                           (let* ((cur (car buf))
                                  (key (car cur))
                                  (val (cdr cur))
                                  (nee (if (eq? #t val) e (env-set e key val))))
                             (loop nee (cdr buf))))))
                    (new-failstate
                     (if ctx
                         (construct-from-alt s (instruction-set-ctx instruction ctx))
                         (state-failstate s))))
               (state instruction
                      (state-stack s)
                      new-env
                      new-failstate)))))))

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
                (backtrack db s))))))

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

;; accepts list of symbols "body"
;; and returns first instruction
(define (build-body body)
  (define rev (reverse body))

  (define (make-one block next)
    (define sign (car block))
    (define args (cdr block))
    (instruction sign args (length args) next #f))

  (define result
    (let lp ((buf rev) (prev #f))
      (if (null? buf)
          prev
          (let ((current (make-one (car buf) prev)))
            (lp (cdr buf) current)))))

  result)

;; accepts list of rules that looks like:
;; '(((abc x) (= x 2))
;;   ((yyy x) (abc x))
;;   ((abc x) (= x 3))
;;   )
;; returns database
(define (create-database botom-handler lst-of-rules)
  (define db (make-database botom-handler))

  (define (handle-rule r)
    (define first (car r))
    (define name (car first))

    (define args-init (cdr first))
    (define body-init (cdr r))

    (define (ret args body-app)
      (let ((body (append body-app body-init)))
        (database-set! db name args body)))

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

  (for-each handle-rule lst-of-rules)

  db)

;; accepts database `db` and list of symbols `query`
;; returns a list of result alists
(define (eval-query db query)
  (define (backtrack-eval db s)
    (let ((b (backtrack db s)))
      (and b (eval-state db b))))

  (define (take-vars s)
    (hashmap->alist (state-env s)))

  (define start-instruction (build-body query))
  (define initial-state (make-state start-instruction))
  (define final-state (eval-state db initial-state))

  (let lp ((s final-state))
    (if s
        (cons (filter (lambda (x) (not (usymbol? (car x)))) (take-vars s))
              (lp (backtrack-eval db s)))
        (list))))

