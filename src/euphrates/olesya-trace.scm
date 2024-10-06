;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define (olesya:trace:eval expr)
  (define wrapped (list 'begin expr)) ;; need this to not polute the outer scope.
  (eval wrapped olesya:trace:environment))


(define-syntax olesya:trace:term
  (syntax-rules ()
    ((_ term)
     (list olesya:term:name (quote term)))))


(define-syntax olesya:trace:rule
  (syntax-rules ()
    ((_ premise consequence)
     (list olesya:rule:name (quote premise) (quote consequence)))))


(define-syntax olesya:trace:define
  (syntax-rules ()
    ((_ name value)
     (define name value))))


(define-syntax olesya:trace:=
  (syntax-rules ()
    ((_ a b) a)))


(define (olesya:trace:map . args)
  (cons 'map args))


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
