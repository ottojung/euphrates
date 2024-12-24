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
  (lesya:interpret:state:struct:construct
   callstack     ;; Just names of variables being defined.
   supposedterms ;; The hypothetical terms introduced by `let` in this scope so far.
   escape        ;; Continuation that returns to the top.
   )

  lesya:interpret:state:struct?

  (callstack lesya:interpret:state:callstack)
  (supposedterms lesya:interpret:state:supposedterms)
  (escape lesya:interpret:state:escape)

  )


(define lesya:interpret:state/p
  (make-parameter #f))

(define (lesya:get-current-stack)
  (define struct (lesya:interpret:state/p))
  (lesya:interpret:state:callstack struct))


(define (lesya:currently-hyphothetical?)
  (define struct (lesya:interpret:state/p))
  (define supposedterms (lesya:interpret:state:supposedterms struct))
  (not (stack-empty? supposedterms)))


(define (lesya:interpret:state:make escape)
  (define callstack (stack-make))
  (define supposedterms (stack-make))
  (lesya:interpret:state:struct:construct
   callstack supposedterms escape))


(define (lesya:error type . args)
  (define state (lesya:interpret:state/p))
  (define stack (lesya:interpret:state:callstack state))
  (define escape (lesya:interpret:state:escape state))

  (escape
   (olesya:return:fail
    (list type args (stack->list stack)))))

(define (lesya:interpret:modus-ponens implication argument)
  (define-values (premise conclusion)
    (lesya:syntax:implication:destruct implication lesya:error))

  (unless (equal? premise argument)
    (lesya:error 'non-matching-modus-ponens
                 (list 'context:
                       'argument: argument
                       'implication: implication
                       'endcontext:)))

  conclusion)


(define during-eval?/p
  (make-parameter #f))


(define (lesya:currently-at-toplevel?)
  (define stack (lesya:get-current-stack))
  (and (stack-empty? stack)
       (not (lesya:currently-hyphothetical?))))


(define (lesya:interpret:beta-reduce initial-term qvarname qreplcement)
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


(define (lesya:interpret:map/unsafe rule body)
  (define-values (premise conclusion)
    (cond
     ((lesya:syntax:implication? rule)
      (lesya:syntax:implication:destruct rule 'impossible))
     ((lesya:syntax:specify? rule)
      (lesya:syntax:specify:destruct rule 'impossible))
     ((lesya:syntax:rule? rule)
      (lesya:syntax:rule:destruct rule 'impossible))
     (else
      (lesya:error 'neither-an-implication-nor-specify-in-substitution rule))))

  (lesya:interpret:beta-reduce
   body premise conclusion))


(define-syntax lesya:interpret:run
  (syntax-rules ()
    ((_ . bodies)
     (call-with-current-continuation
      (lambda (k)
        (define state (lesya:interpret:state:make k))
        (define result
          (parameterize ((lesya:interpret:state/p state))
            (let () . bodies)))
        (olesya:return:ok result))))))


(define-syntax lesya:interpret:begin
  (syntax-rules ()
    ((_ . args) (begin . args))))


(define-syntax lesya:check-that-on-toplevel
  (syntax-rules ()
    ((_ body)
     (cond
      ((during-eval?/p) body)
      ((not (lesya:currently-hyphothetical?)) body)
      (else
       (lesya:error 'only-allowed-on-top-level
                    (stringf "This operation is only allowed on toplevel: ~s." (quote body))))))))


(define-syntax lesya:interpret:axiom
  (syntax-rules ()
    ((_ term)
     (lesya:check-that-on-toplevel
      (quasiquote term)))))



(define (lesya:interpret:apply . arguments)
  (list-fold/semigroup lesya:interpret:modus-ponens arguments))


(define-syntax lesya:interpret:specify
  (syntax-rules ()
    ((_ varname subterm)
     (lesya:syntax:specify:make
      (quasiquote varname) (quasiquote subterm)))))


(define-syntax lesya:interpret:define
  (syntax-rules ()
    ((_ name arg)
     (define name
       (let ()
         (define stack (lesya:get-current-stack))
         (define _res (stack-push! stack (quasiquote name)))
         (define result arg)
         (stack-pop! stack)
         result)))))

(define-syntax lesya:interpret:let
  (syntax-rules ()
    ((_ () . bodies)
     (let () . bodies))

    ((_  ((x shape) . lets) . bodies)
     (let ()
       (define x (quasiquote shape))
       (define state (lesya:interpret:state/p))
       (define supposedterms (lesya:interpret:state:supposedterms state))
       (define _re (stack-push! supposedterms x))
       (define result (lesya:interpret:let lets . bodies))
       (stack-pop! supposedterms)
       (lesya:syntax:implication:make x result)))))


(define-syntax lesya:interpret:=
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


(define (lesya:interpret:map rule body)
  (lesya:check-that-on-toplevel
   (lesya:interpret:map/unsafe rule body)))


(define (lesya:interpret:eval expr)
  (parameterize ((during-eval?/p #t))
    (eval expr (lesya:environment))))


(define (lesya:environment)
  (environment
   '(only (scheme base) unquote)
   '(rename (euphrates lesya-interpret)
            (lesya:interpret:axiom axiom)
            (lesya:interpret:define define)
            (lesya:interpret:apply apply)
            (lesya:interpret:begin begin)
            (lesya:interpret:specify specify)
            (lesya:interpret:let let)
            (lesya:interpret:= =)
            (lesya:interpret:map map)
            (lesya:interpret:eval eval)
            )))


(define (lesya:interpret program)
  (lesya:interpret:run
   (eval program (lesya:environment))))
