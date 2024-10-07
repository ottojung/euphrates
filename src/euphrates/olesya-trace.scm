;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define (olesya:traced-object:make operation output)
  (vector output operation))

(define (olesya:traced-object:operation obj)
  (vector-ref obj 1))

(define (olesya:traced-object:output obj)
  (vector-ref obj 0))

(define (olesya:traced-object? obj)
  (and (vector? obj)
       (= 2 (vector-length obj))))


(define (olesya:trace:eval expr)
  (if (olesya:traced-object? expr)
      (let ()
        (define expr:value
          (olesya:traced-object:output expr))

        (define operation
          (list 'eval expr))
        (define output
          (olesya:trace:eval expr:value))

        (define ret
          (olesya:traced-object:make
           operation output))

        ret)
      (eval expr olesya:trace:environment)))


(define-syntax olesya:trace:term
  (syntax-rules ()
    ((_ term)
     (let ()
       (define operation (olesya:treeify:term term))
       (define output (olesya:language:term term))
       (olesya:traced-object:make operation output)))))


(define-syntax olesya:trace:rule
  (syntax-rules ()
    ((_ premise consequence)
     (let ()
       (define operation (olesya:treeify:rule premise consequence))
       (define output (olesya:language:rule premise consequence))
       (olesya:traced-object:make operation output)))))


(define-syntax olesya:trace:define
  (syntax-rules ()
    ((_ name value)
     (define name value))))


(define-syntax olesya:trace:=
  (syntax-rules ()
    ((_ a b)
     a ;; TODO: check if `a` is equal to `b`.
     )))



(define (olesya:trace:map rule body)
  (define rule:value
    (olesya:traced-object:output rule))
  (define body:value
    (olesya:traced-object:output body))
  (define operation
    (olesya:treeify:map rule body))
  (define output
    (olesya:language:map rule:value body:value))

  (olesya:traced-object:make
   operation output))


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
            (olesya:trace:= =)
            (olesya:trace:map map)
            (olesya:trace:begin begin))))


(define (olesya:trace expr)
  (olesya:trace:eval expr))
