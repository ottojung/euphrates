;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define-type9 <olesya:traced-object>
  (olesya:traced-object:make
   value
   trace
   )

  olesya:traced-object?

  (value olesya:traced-object:value)
  (trace olesya:traced-object:trace)

  )


(define (olesya:trace+interpret:eval expr)
  (if (olesya:traced-object? expr)
      (let ()
        (define value
          (olesya:traced-object:value expr))
        (define trace
          (olesya:traced-object:trace expr))

        (define new-expr
          (olesya:trace+interpret:eval value))

        (define new-value
          (olesya:traced-object:value new-expr))
        (define new-trace
          (olesya:traced-object:trace new-expr))

        (define ret-value
          new-value)
        (define ret-trace
          (list
           'eval
           (olesya:language:map
            (list olesya:rule:name value trace)
            new-trace)))

        (define ret
          (olesya:traced-object:make
           ret-value ret-trace))

        ret)
      (eval expr olesya:trace+interpret:environment)))


(define-syntax olesya:trace+interpret:term
  (syntax-rules ()
    ((_ term)
     (olesya:traced-object:make
      (olesya:language:term term)
      (olesya:treeify:term term)))))


(define-syntax olesya:trace+interpret:rule
  (syntax-rules ()
    ((_ premise consequence)
     (olesya:traced-object:make
      (olesya:language:rule premise consequence)
      (olesya:treeify:rule premise consequence)))))


(define-syntax olesya:trace+interpret:define
  (syntax-rules ()
    ((_ name value)
     (define name value))))


(define-syntax olesya:trace+interpret:=
  (syntax-rules ()
    ((_ a b)
     a ;; TODO: check if `a` is equal to `b`.
     )))



(define (olesya:trace+interpret:map rule body)
  (define rule:value
    (olesya:traced-object:value rule))
  (define body:value
    (olesya:traced-object:value body))
  (define rule:trace
    (olesya:traced-object:trace rule))
  (define body:trace
    (olesya:traced-object:trace body))

  (olesya:traced-object:make
   (olesya:language:map rule:value body:value)
   (olesya:treeify:map rule:trace body:trace)))



(define-syntax olesya:trace+interpret:begin
  (syntax-rules ()
    ((_ . args) (let () . args))))


(define olesya:trace+interpret:environment
  (environment
   '(rename (euphrates olesya-trace+interpret)
            (olesya:trace+interpret:eval eval)
            (olesya:trace+interpret:term term)
            (olesya:trace+interpret:rule rule)
            (olesya:trace+interpret:define define)
            (olesya:trace+interpret:= =)
            (olesya:trace+interpret:map map)
            (olesya:trace+interpret:begin begin))))


(define (olesya:trace+interpret expr)
  (olesya:trace+interpret:eval expr))
