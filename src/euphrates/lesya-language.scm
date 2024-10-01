;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;
;;
;;
;; Throughout a lasting night of darkness
;; Ne'er shall I rest my own eyes,
;; Always searching for the guiding star,
;; The bright empress of the dark night skies.
;;
;;


(define-type9 <lesya:struct>
  (lesya:language:state:struct:construct
   callstack     ;; Just names of variables being defined.
   supposedterms ;; The hypothetical terms introduced by `let` in this scope so far.
   escape        ;; Continuation that returns to the top.
   )

  lesya:language:state:struct?

  (callstack lesya:language:state:callstack)
  (supposedterms lesya:language:state:supposedterms)
  (escape lesya:language:state:escape)

  )


(define (lesya:language:state:make escape)
  (define callstack (stack-make))
  (define supposedterms (stack-make))
  (lesya:language:state:struct:construct
   callstack supposedterms escape))

(define lesya:language:state/p
  (make-parameter #f))

(define-syntax lesya:language:run
  (syntax-rules ()
    ((_ . bodies)
     (call-with-current-continuation
      (lambda (k)
        (define state (lesya:language:state:make k))
        (parameterize ((lesya:language:state/p state))
          (let () . bodies))
        (list 'ok))))))

(define-syntax lesya:language:begin
  (syntax-rules ()
    ((_ . args) (begin . args))))


(define (lesya:get-current-stack)
  (define struct (lesya:language:state/p))
  (lesya:language:state:callstack struct))


(define (lesya:currently-hyphothetical?)
  (define struct (lesya:language:state/p))
  (define supposedterms (lesya:language:state:supposedterms struct))
  (not (stack-empty? supposedterms)))


(define-syntax lesya:check-that-on-toplevel
  (syntax-rules ()
    ((_ body)
     (if (lesya:currently-hyphothetical?)
         (lesya:error 'only-allowed-on-top-level
                      (stringf "This operation is only allowed on toplevel: ~s." (quote body)))
         body))))


(define-syntax lesya:language:axiom
  (syntax-rules ()
    ((_ term)
     (lesya:check-that-on-toplevel
      (quasiquote term)))))


(define (lesya:language:beta-reduce initial-term qvarname qreplcement)
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

(define (lesya:error type . args)
  (define state (lesya:language:state/p))
  (define stack (lesya:language:state:callstack state))
  (define escape (lesya:language:state:escape state))

  (escape (list 'error type args (stack->list stack))))

(define lesya:implication:name
  'if)

(define lesya:substitution:name
  'map)

(define lesya:specify:name
  'specify)

(define (lesya:specify:make supposition conclusion)
  `(,lesya:specify:name ,supposition ,conclusion))

(define (lesya:implication:make supposition conclusion)
  `(,lesya:implication:name ,supposition ,conclusion))


(define (lesya:implication:check implication)
  (or
   (and (not (list? implication))
        (list 'not-a-term-in-implication implication))
   (and (not (pair? implication))
        (lesya:error 'null-in-implication implication))
   (and (not (list-length= 3 implication))
        (list 'bad-length-of-implication-in-modus-ponens implication))
   (let ()
     (define-tuple (predicate premise conclusion) implication)

     (and (not (equal? predicate lesya:implication:name))
          (list 'non-implication-in-modus-ponens implication)))))


(define (lesya:implication? implication)
  (not (lesya:implication:check implication)))


(define (lesya:implication:destruct implication)
  (define error (lesya:implication:check implication))
  (when error
    (apply lesya:error error))

  (let ()
    (define-tuple (predicate premise conclusion) implication)
    (values premise conclusion)))


(define (lesya:specify:check specify)
  (or
   (and (not (list? specify))
        (list 'not-a-term-in-specify specify))
   (and (not (pair? specify))
        (lesya:error 'null-in-specify specify))
   (and (not (list-length= 3 specify))
        (list 'bad-length-of-specify-in-modus-ponens specify))
   (let ()
     (define-tuple (predicate premise conclusion) specify)

     (and (not (equal? predicate lesya:specify:name))
          (list 'non-specify-in-modus-ponens specify)))))


(define (lesya:specify? specify)
  (not (lesya:specify:check specify)))


(define (lesya:specify:destruct specify)
  (define error (lesya:specify:check specify))
  (when error
    (apply lesya:error error))

  (let ()
    (define-tuple (predicate premise conclusion) specify)
    (values premise conclusion)))


(define (lesya:language:modus-ponens implication argument)
  (define-values (premise conclusion)
    (lesya:implication:destruct implication))

  (unless (equal? premise argument)
    (lesya:error 'non-matching-modus-ponens
                 (list 'context:
                       'argument: argument
                       'implication: implication
                       'endcontext:)))

  conclusion)

(define (lesya:language:apply . arguments)
  (list-fold/semigroup lesya:language:modus-ponens arguments))

(define (lesya:currently-at-toplevel?)
  (define stack (lesya:get-current-stack))
  (and (stack-empty? stack)
       (not (lesya:currently-hyphothetical?))))


(define (lesya:specify qvarname qsubterm)
  (unless (symbol? qvarname)
    (lesya:error 'non-symbol-in-specify qvarname qsubterm))

  (lesya:specify:make qvarname qsubterm))


(define-syntax lesya:language:specify
  (syntax-rules ()
    ((_ varname subterm)
     (lesya:specify (quasiquote varname) (quasiquote subterm)))))


(define-syntax lesya:language:define
  (syntax-rules ()
    ((_ name arg)
     (define name
       (let ()
         (define stack (lesya:get-current-stack))
         (define _res (stack-push! stack (quasiquote name)))
         (define result arg)
         (stack-pop! stack)
         result)))))

(define-syntax lesya:language:let
  (syntax-rules ()
    ((_ () . bodies)
     (let () . bodies))

    ((_  ((x shape) . lets) . bodies)
     (let ()
       (define x (quasiquote shape))
       (define state (lesya:language:state/p))
       (define supposedterms (lesya:language:state:supposedterms state))
       (define _re (stack-push! supposedterms x))
       (define result (lesya:language:let lets . bodies))
       (stack-pop! supposedterms)
       (lesya:implication:make x result)))))


(define-syntax lesya:language:=
  (syntax-rules ()
    ((_ a b)
     (let ()
       (define a* a)
       (define b* (quasiquote b))
       (if (equal? a* b*) a*
           (lesya:error
            'terms-are-not-equal
            (list 'context:
                  'actual: a*
                  'expected: b*
                  'endcontext:)))))))


(define (lesya:language:map rule body)
  (lesya:check-that-on-toplevel
   (lesya:language:map/unsafe rule body)))


(define (lesya:language:map/unsafe rule body)
  (define-values (premise conclusion)
    (cond
     ((lesya:implication? rule)
      (lesya:implication:destruct rule))
     ((lesya:specify? rule)
      (lesya:specify:destruct rule))
     (else
      (lesya:error 'neither-an-implication-nor-specify-in-substitution rule))))

  (lesya:language:beta-reduce
   body premise conclusion))


(define (lesya:language:eval expr)
  (cond
   ((and (pair? expr) (list? expr))
    (let ()
      (define operation (car expr))

      (cond
       ((equal? operation lesya:substitution:name)
        (let ()
          (define-tuple (operation rule body) expr)
          (lesya:language:map/unsafe rule body)))

       (else
        (lesya:error 'unknown-operation-in-eval operation expr)))))

   (else
    (lesya:error 'non-expression-in-eval expr))))
