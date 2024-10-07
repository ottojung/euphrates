;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define (olesya:treeify:eval expr)
  (define wrapped (list 'begin expr)) ;; need this to not polute the outer scope.
  (list 'eval (eval wrapped olesya:treeify:environment)))


(define-syntax olesya:treeify:term
  (syntax-rules ()
    ((_ term)
     (list olesya:term:name (quote term)))))


(define-syntax olesya:treeify:rule
  (syntax-rules ()
    ((_ premise consequence)
     (list olesya:rule:name (quote premise) (quote consequence)))))


(define-syntax olesya:treeify:define
  (syntax-rules ()
    ((_ name value)
     (define name value))))


(define-syntax olesya:treeify:=
  (syntax-rules ()
    ((_ a b) a)))


(define (olesya:treeify:map . args)
  (cons olesya:substitution:name args))


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
            (olesya:treeify:= =)
            (olesya:treeify:map map)
            (olesya:treeify:begin begin))))


(define (olesya:treeify expr)
  (define wrapped (list 'begin expr)) ;; need this to not polute the outer scope.
  (eval wrapped olesya:treeify:environment))
