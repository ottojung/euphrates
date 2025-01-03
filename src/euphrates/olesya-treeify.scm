;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define (olesya:treeify:eval expr)
  (define wrapped (olesya:syntax:begin:make expr)) ;; need this to not polute the outer scope.
  (olesya:syntax:eval:make
   (eval wrapped olesya:treeify:environment)))


(define-syntax olesya:treeify:term
  (syntax-rules ()
    ((_ term)
     (olesya:syntax:term:make (quote term)))))


(define-syntax olesya:treeify:rule
  (syntax-rules ()
    ((_ premise consequence)
     (olesya:syntax:rule:make
      (quote premise) (quote consequence)))))


(define-syntax olesya:treeify:define
  (syntax-rules ()
    ((_ name value)
     (define name value))))


(define-syntax olesya:treeify:let
  (syntax-rules ()
    ((_ () . bodies)
     (olesya:treeify:begin . bodies))

    ((_  ((name expr) . lets) . bodies)
     (olesya:syntax:let:make
      (list (list (quote name) (quote expr)))
      (olesya:treeify:let lets . bodies)))))


(define-syntax olesya:treeify:=
  (syntax-rules ()
    ((_ a b) a)))


(define (olesya:treeify:map rule subject)
  (olesya:syntax:substitution:make rule subject))


(define-syntax olesya:treeify:begin
  (syntax-rules ()
    ((_ . args) (let () . args))))


(define olesya:treeify:environment
  (environment
   '(rename (euphrates olesya-treeify)
            (olesya:treeify:eval eval)
            (olesya:treeify:term term)
            (olesya:treeify:rule rule)
            (olesya:treeify:define define)
            (olesya:treeify:let let)
            (olesya:treeify:= =)
            (olesya:treeify:map map)
            (olesya:treeify:begin begin))))


(define (olesya:treeify expr)
  (define wrapped (olesya:syntax:begin:make expr)) ;; need this to not polute the outer scope.
  (eval wrapped olesya:treeify:environment))
