;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define olesya:syntax:term:name
  'term)


(define (olesya:syntax:term:make object)
  (or
   (and (not (list? object))
        (list 'not-a-constructor-for-term object))
   (and (not (pair? object))
        (list 'null-for-term object))
   (and (not (list-length= 2 object))
        (list 'bad-length-for-term object))
   (let ()
     (define-tuple (predicate premise conclusion) object)
     (and (not (equal? predicate olesya:syntax:term:name))
          (list 'wrong-constructor-for-term object)))))


(define (olesya:syntax:term:check object)
  (or
   (and (not (list? object))
        (list 'not-a-constructor-for-term object))
   (and (not (pair? object))
        (list 'null-for-term object))
   (and (not (list-length= 2 object))
        (list 'bad-length-for-term object))
   (let ()
     (define-tuple (predicate term) object)
     (and (not (equal? predicate olesya:syntax:term:name))
          (list 'wrong-constructor-for-term object)))))


(define (olesya:syntax:term? object)
  (not (olesya:syntax:term:check object)))


(define (olesya:syntax:term:destruct object on-error)
  (define error (olesya:syntax:term:check object))
  (when error
    (apply on-error error))

  (let ()
    (define-tuple (predicate term) object)
    term))


(define olesya:syntax:rule:name
  'rule)


(define (olesya:syntax:rule:make object)
  (or
   (and (not (list? object))
        (list 'not-a-constructor-for-rule object))
   (and (not (pair? object))
        (list 'null-for-rule object))
   (and (not (list-length= 2 object))
        (list 'bad-length-for-rule object))
   (let ()
     (define-tuple (predicate premise conclusion) object)
     (and (not (equal? predicate olesya:syntax:rule:name))
          (list 'wrong-constructor-for-rule object)))))


(define (olesya:syntax:rule:check object)
  (or
   (and (not (list? object))
        (list 'not-a-constructor-for-rule object))
   (and (not (pair? object))
        (list 'null-for-rule object))
   (and (not (list-length= 3 object))
        (list 'bad-length-for-rule object))
   (let ()
     (define-tuple (predicate premise consequence) object)
     (and (not (equal? predicate olesya:syntax:rule:name))
          (list 'wrong-constructor-for-rule object)))))


(define (olesya:syntax:rule? object)
  (not (olesya:syntax:rule:check object)))


(define (olesya:syntax:rule:destruct object on-error)
  (define error (olesya:syntax:rule:check object))
  (when error
    (apply on-error error))

  (let ()
    (define-tuple (predicate premise consequence) object)
    (values premise consequence)))
