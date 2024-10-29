;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (lesya:compile/->olesya program)

  



  0)




(define-syntax lesya:interpret:begin
  (syntax-rules ()
    ((_ . args) (begin . args))))


(define-syntax lesya:check-that-on-toplevel
  (syntax-rules ()
    ((_ body)
     (if (lesya:currently-hyphothetical?)
         (lesya:error 'only-allowed-on-top-level
                      (stringf "This operation is only allowed on toplevel: ~s." (quote body)))
         body))))


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
  (cond
   ((and (pair? expr) (list? expr))
    (let ()
      (define operation (car expr))

      (cond
       ((lesya:syntax:substitution? expr)
        (let ()
          (define-values (rule body)
            (lesya:syntax:substitution:destruct expr 'impossible))
          (lesya:interpret:map/unsafe rule body)))

       (else
        (lesya:error 'unknown-operation-in-eval operation expr)))))

   (else
    (lesya:error 'non-expression-in-eval expr))))


(define lesya:environment
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
  (define escaped
    ;; Following escape is needed to not polute the toplevel environment of Lesya.
    ;; Zero at the end is just to allow `program` to end with `define`.
    `(let () ,program 0))

  (lesya:interpret:run
   (eval escaped lesya:environment)))

