;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;
;;
;;
;; My only weapon, dear words that I cherish,
;; We must ensure that not both of us perish!
;; Wielded by brothers we do not yet know,
;; You may do better in routing the foe.
;;
;;


(define-type9 <olesya:struct>
  (olesya:language:state:struct:construct
   callstack     ;; Just names of variables being defined.
   supposedterms ;; The hypothetical terms introduced by `let` in this scope so far.
   escape        ;; Continuation that returns to the top.
   )

  olesya:language:state:struct?

  (callstack olesya:language:state:callstack)
  (supposedterms olesya:language:state:supposedterms)
  (escape olesya:language:state:escape)

  )


(define (olesya:language:state:make escape)
  (define callstack (stack-make))
  (define supposedterms (stack-make))
  (olesya:language:state:struct:construct
   callstack supposedterms escape))

(define olesya:language:state/p
  (make-parameter #f))

(define-syntax olesya:language:run
  (syntax-rules ()
    ((_ . bodies)
     (call-with-current-continuation
      (lambda (k)
        (define state (olesya:language:state:make k))
        (parameterize ((olesya:language:state/p state))
          (let () . bodies))
        (list 'ok))))))

(define-syntax olesya:language:begin
  (syntax-rules ()
    ((_ . args) (begin . args))))


(define (olesya:get-current-stack)
  (define struct (olesya:language:state/p))
  (olesya:language:state:callstack struct))


(define (olesya:currently-hyphothetical?)
  (define struct (olesya:language:state/p))
  (define supposedterms (olesya:language:state:supposedterms struct))
  (not (stack-empty? supposedterms)))


(define-syntax olesya:check-that-on-toplevel
  (syntax-rules ()
    ((_ body)
     (if (olesya:currently-hyphothetical?)
         (olesya:error 'only-allowed-on-top-level
                      (stringf "This operation is only allowed on toplevel: ~s." (quote body)))
         body))))


(define-syntax olesya:language:axiom
  (syntax-rules ()
    ((_ term)
     (olesya:check-that-on-toplevel
      (quasiquote term)))))


(define (olesya:language:beta-reduce initial-term qvarname qreplcement)
  (let loop ((term initial-term))
    (cond
     ((equal? term qvarname)
      qreplcement)
     ((null? term)
      term)
     ((list? term)
      (cons (car term) (map loop (cdr term))))
     (else
      term))))

(define (olesya:error type . args)
  (define state (olesya:language:state/p))
  (define stack (olesya:language:state:callstack state))
  (define escape (olesya:language:state:escape state))

  (escape (list 'error type args (stack->list stack))))

(define olesya:implication:name
  'if)

(define olesya:substitution:name
  'map)

(define olesya:specify:name
  'rule)

(define (olesya:specify:make supposition conclusion)
  `(,olesya:specify:name ,supposition ,conclusion))

(define (olesya:implication:make supposition conclusion)
  `(,olesya:implication:name ,supposition ,conclusion))


(define (olesya:implication:check implication)
  (or
   (and (not (list? implication))
        (list 'not-a-term-in-implication implication))
   (and (not (pair? implication))
        (olesya:error 'null-in-implication implication))
   (and (not (list-length= 3 implication))
        (list 'bad-length-of-implication-in-modus-ponens implication))
   (let ()
     (define-tuple (predicate premise conclusion) implication)

     (and (not (equal? predicate olesya:implication:name))
          (list 'non-implication-in-modus-ponens implication)))))


(define (olesya:implication? implication)
  (not (olesya:implication:check implication)))


(define (olesya:implication:destruct implication)
  (define error (olesya:implication:check implication))
  (when error
    (apply olesya:error error))

  (let ()
    (define-tuple (predicate premise conclusion) implication)
    (values premise conclusion)))


(define (olesya:specify:check specify)
  (or
   (and (not (list? specify))
        (list 'not-a-term-in-specify specify))
   (and (not (pair? specify))
        (olesya:error 'null-in-specify specify))
   (and (not (list-length= 3 specify))
        (list 'bad-length-of-specify-in-modus-ponens specify))
   (let ()
     (define-tuple (predicate premise conclusion) specify)

     (and (not (equal? predicate olesya:specify:name))
          (list 'non-specify-in-modus-ponens specify)))))


(define (olesya:specify? specify)
  (not (olesya:specify:check specify)))


(define (olesya:specify:destruct specify)
  (define error (olesya:specify:check specify))
  (when error
    (apply olesya:error error))

  (let ()
    (define-tuple (predicate premise conclusion) specify)
    (values premise conclusion)))


(define (olesya:language:modus-ponens implication argument)
  (define-values (premise conclusion)
    (olesya:specify:destruct implication))

  (unless (equal? premise argument)
    (olesya:error 'non-matching-modus-ponens
                 (list 'context:
                       'argument: argument
                       'implication: implication
                       'endcontext:)))

  conclusion)

(define (olesya:language:apply . arguments)
  (list-fold/semigroup olesya:language:modus-ponens arguments))

(define (olesya:currently-at-toplevel?)
  (define stack (olesya:get-current-stack))
  (and (stack-empty? stack)
       (not (olesya:currently-hyphothetical?))))


(define (olesya:specify qvarname qsubterm)
  (unless (symbol? qvarname)
    (olesya:error 'non-symbol-in-specify qvarname qsubterm))

  (olesya:specify:make qvarname qsubterm))


(define-syntax olesya:language:specify
  (syntax-rules ()
    ((_ varname subterm)
     (olesya:specify (quasiquote varname) (quasiquote subterm)))))


(define-syntax olesya:language:define
  (syntax-rules ()
    ((_ name arg)
     (define name
       (let ()
         (define stack (olesya:get-current-stack))
         (define _res (stack-push! stack (quasiquote name)))
         (define result arg)
         (stack-pop! stack)
         result)))))

(define-syntax olesya:language:let
  (syntax-rules ()
    ((_ () . bodies)
     (let () . bodies))

    ((_  ((x shape) . lets) . bodies)
     (let ()
       (define x (quasiquote shape))
       (define state (olesya:language:state/p))
       (define supposedterms (olesya:language:state:supposedterms state))
       (define _re (stack-push! supposedterms x))
       (define result (olesya:language:let lets . bodies))
       (stack-pop! supposedterms)
       (olesya:implication:make x result)))))


(define-syntax olesya:language:=
  (syntax-rules ()
    ((_ a b)
     (let ()
       (define a* a)
       (define b* (quasiquote b))
       (if (equal? a* b*) a*
           (olesya:error
            'terms-are-not-equal
            (list 'context:
                  'actual: a*
                  'expected: b*
                  'endcontext:)))))))


(define (olesya:language:map rule body)
  (olesya:check-that-on-toplevel
   (olesya:language:map/unsafe rule body)))


(define (olesya:language:map/unsafe rule body)
  (define-values (premise conclusion)
    (cond
     ((olesya:specify? rule)
      (olesya:specify:destruct rule))
     (else
      (olesya:error 'not-a-rule-in-substitution rule))))

  (olesya:language:beta-reduce
   body premise conclusion))


(define (olesya:language:eval expr)
  (cond
   ((and (pair? expr) (list? expr))
    (let ()
      (define operation (car expr))

      (cond
       ((equal? operation olesya:substitution:name)
        (let ()
          (define-tuple (operation rule body) expr)
          (olesya:language:map/unsafe rule body)))

       (else
        (olesya:error 'unknown-operation-in-eval operation expr)))))

   (else
    (olesya:error 'non-expression-in-eval expr))))
