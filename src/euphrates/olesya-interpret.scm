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


(define olesya:interpret:escape/p
  (make-parameter #f))


(define-syntax olesya:interpret:run
  (syntax-rules ()
    ((_ . bodies)
     (call-with-current-continuation
      (lambda (k)
        (define result
          (parameterize ((olesya:interpret:escape/p k))
            (let () . bodies)))
        (list 'ok result))))))


(define-syntax olesya:interpret:begin
  (syntax-rules ()
    ((_ . args) (begin . args))))


(define-syntax olesya:interpret:term
  (syntax-rules ()
    ((_ term)
     (olesya:syntax:term:make (quote term)))))


(define-syntax olesya:interpret:rule
  (syntax-rules ()
    ((_ premise consequence)
     (olesya:syntax:rule:make (quote premise) (quote consequence)))))


(define (olesya:interpret:beta-reduce term qvarname qreplcement)
  (let loop ((term term))
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
  (define escape (olesya:interpret:escape/p))
  (escape (list 'error type args)))


(define-syntax olesya:interpret:define
  (syntax-rules ()
    ((_ name expr)
     (define name expr))))


(define-syntax olesya:interpret:let
  (syntax-rules ()
    ((_ () . bodies)
     (let () . bodies))

    ((_  ((name expr) . lets) . bodies)
     (let ()
       (define name expr)
       (define result (olesya:interpret:let lets . bodies))
       (olesya:syntax:rule:make name result)))))


;;
;; TODO: remove this. Instead use `(term (= a b))` and then check if the terms are equal during `olesya:reverse`.
;;
(define-syntax olesya:interpret:=
  (syntax-rules ()
    ((_ a b)
     (let ()
       (define a* a)
       (define b* (quote b))
       (if (equal? a* b*) a*
           (olesya:error
            'terms-are-not-equal
            (list 'context:
                  'actual: a*
                  'expected: b*
                  'endcontext:)))))))


(define (olesya:interpret:map rule body)
  (define escape (olesya:interpret:escape/p))
  (define-values (premise conclusion)
    (olesya:syntax:rule:destruct rule escape))

  (olesya:interpret:beta-reduce
   body premise conclusion))


(define (olesya:interpret:eval expr)
  (eval expr (olesya:environment)))


(define (olesya:environment)
  (environment
   '(rename (euphrates olesya-interpret)
            (olesya:interpret:eval eval)
            (olesya:interpret:term term)
            (olesya:interpret:rule rule)
            (olesya:interpret:define define)
            (olesya:interpret:let let)
            (olesya:interpret:= =)
            (olesya:interpret:map map)
            (olesya:interpret:begin begin))))


(define (olesya:interpret program)
  (olesya:interpret:run
   (olesya:interpret:eval program)))
