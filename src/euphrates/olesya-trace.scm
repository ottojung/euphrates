;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define olesya:trace:callback/p
  (make-parameter (lambda _ (values))))


(define olesya:trace:in-eval?
  (make-parameter #f))


(define-syntax olesya:trace:with-callback
  (syntax-rules ()
    ((_ callback . bodies)
     (parameterize ((olesya:trace:callback/p callback))
       (let () . bodies)))))


(define (olesya:trace:callback operation output)
  (define fun (olesya:trace:callback/p))
  (fun operation output))


(define (olesya:trace:eval expr)
  (define operation
    (list olesya:eval:name expr))

  (define output
    (parameterize ((olesya:trace:in-eval? #t))
      (olesya:trace expr)))

  (olesya:trace:callback operation output)

  output)


(define-syntax olesya:trace:term
  (syntax-rules ()
    ((_ term)
     (let ()
       (define operation (olesya:treeify:term term))
       (define output (olesya:language:term term))
       (olesya:trace:callback operation output)
       output))))


(define-syntax olesya:trace:rule
  (syntax-rules ()
    ((_ premise consequence)
     (let ()
       (define operation (olesya:treeify:rule premise consequence))
       (define output (olesya:language:rule premise consequence))
       (olesya:trace:callback operation output)
       output))))


(define-syntax olesya:trace:define
  (syntax-rules ()
    ((_ name value)
     (define name value))))


(define olesya:trace:let-stack
  (make-parameter '()))


(define-syntax olesya:trace:let
  (syntax-rules ()
    ((_ () . bodies)
     (let () . bodies))

    ((_  ((name expr) . lets) . bodies)
     (parameterize ((olesya:trace:let-stack
                     (cons
                      (list (quote name) (quote expr))
                      (olesya:trace:let-stack))))
       (let ((name expr))
         (define result (olesya:trace:let lets . bodies))
         (define operation
           (olesya:treeify:let ((name expr)) result))
         (define output
           (olesya:rule:make name result))
         (olesya:trace:callback operation output)
         output)))))


(define-syntax olesya:trace:=
  (syntax-rules ()
    ((_ a b)
     a ;; TODO: check if `a` is equal to `b`.
     )))


(define (olesya:trace:map rule body)
  (define operation
    (olesya:treeify:map rule body))
  (define output
    (olesya:language:map rule body))

  (olesya:trace:callback operation output)

  output)


(define-syntax olesya:trace:begin
  (syntax-rules ()
    ((_ . args) (let () . args))))


(define olesya:trace:environment
  (environment
   '(rename (euphrates olesya-trace)
            (olesya:trace:eval eval)
            (olesya:trace:term term)
            (olesya:trace:rule rule)
            (olesya:trace:define define)
            (olesya:trace:let let)
            (olesya:trace:= =)
            (olesya:trace:map map)
            (olesya:trace:begin begin))))


(define (olesya:trace expr)
  (eval expr olesya:trace:environment))
