;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define lesya:syntax:axiom:name
  'axiom)


(define (lesya:syntax:axiom:make object)
  (list lesya:syntax:axiom:name object))


(define (lesya:syntax:axiom:check object)
  (or
   (and (not (list? object))
        (list 'not-a-constructor-for-axiom object))
   (and (not (pair? object))
        (list 'null-for-axiom object))
   (and (not (list-length= 2 object))
        (list 'bad-length-for-axiom object))
   (and (not (equal? (car object) lesya:syntax:axiom:name))
        (list 'wrong-constructor-for-axiom object))))


(define (lesya:syntax:axiom? object)
  (not (lesya:syntax:axiom:check object)))


(define (lesya:syntax:axiom:destruct object on-error)
  (define error (lesya:syntax:axiom:check object))
  (when error
    (apply on-error error))

  (let ()
    (define-tuple (predicate axiom) object)
    axiom))


(define lesya:syntax:rule:name
  'rule)


(define (lesya:syntax:rule:make premise consequence)
  (list lesya:syntax:rule:name premise consequence))


(define (lesya:syntax:rule:check object)
  (or
   (and (not (list? object))
        (list 'not-a-constructor-for-rule object))
   (and (not (pair? object))
        (list 'null-for-rule object))
   (and (not (list-length= 3 object))
        (list 'bad-length-for-rule object))
   (and (not (equal? (car object) lesya:syntax:rule:name))
        (list 'wrong-constructor-for-rule object))))


(define (lesya:syntax:rule? object)
  (not (lesya:syntax:rule:check object)))


(define (lesya:syntax:rule:destruct object on-error)
  (define error (lesya:syntax:rule:check object))
  (when error
    (apply on-error error))

  (let ()
    (define-tuple (predicate premise consequence) object)
    (values premise consequence)))


(define lesya:syntax:substitution:name
  'map)


(define (lesya:syntax:substitution:make premise consequence)
  (list lesya:syntax:substitution:name premise consequence))


(define (lesya:syntax:substitution:check object)
  (or
   (and (not (list? object))
        (list 'not-a-constructor-for-substitution object))
   (and (not (pair? object))
        (list 'null-for-substitution object))
   (and (not (list-length= 3 object))
        (list 'bad-length-for-substitution object))
   (and (not (equal? (car object) lesya:syntax:substitution:name))
        (list 'wrong-constructor-for-substitution object))))


(define (lesya:syntax:substitution? object)
  (not (lesya:syntax:substitution:check object)))


(define (lesya:syntax:substitution:destruct object on-error)
  (define error (lesya:syntax:substitution:check object))
  (when error
    (apply on-error error))

  (let ()
    (define-tuple (predicate premise consequence) object)
    (values premise consequence)))


(define lesya:syntax:implication:name
  'if)


(define (lesya:syntax:implication:make premise consequence)
  (list lesya:syntax:implication:name premise consequence))


(define (lesya:syntax:implication:check object)
  (or
   (and (not (list? object))
        (list 'not-a-constructor-for-implication object))
   (and (not (pair? object))
        (list 'null-for-implication object))
   (and (not (list-length= 3 object))
        (list 'bad-length-for-implication object))
   (and (not (equal? (car object) lesya:syntax:implication:name))
        (list 'wrong-constructor-for-implication object))))


(define (lesya:syntax:implication? object)
  (not (lesya:syntax:implication:check object)))


(define (lesya:syntax:implication:destruct object on-error)
  (define error (lesya:syntax:implication:check object))
  (when error
    (apply on-error error))

  (let ()
    (define-tuple (predicate premise consequence) object)
    (values premise consequence)))


(define lesya:syntax:specify:name
  'specify)


(define (lesya:syntax:specify:make premise consequence)
  (list lesya:syntax:specify:name premise consequence))


(define (lesya:syntax:specify:check object)
  (or
   (and (not (list? object))
        (list 'not-a-constructor-for-specify object))
   (and (not (pair? object))
        (list 'null-for-specify object))
   (and (not (list-length= 3 object))
        (list 'bad-length-for-specify object))
   (and (not (equal? (car object) lesya:syntax:specify:name))
        (list 'wrong-constructor-for-specify object))
   (and (not (symbol? (cadr object)))
        (list 'specify-must-have-symbol-at-position-0 object))))


(define (lesya:syntax:specify? object)
  (not (lesya:syntax:specify:check object)))


(define (lesya:syntax:specify:destruct object on-error)
  (define error (lesya:syntax:specify:check object))
  (when error
    (apply on-error error))

  (let ()
    (define-tuple (predicate premise consequence) object)
    (values premise consequence)))


(define lesya:syntax:eval:name
  'eval)


(define (lesya:syntax:eval:make object)
  (list lesya:syntax:eval:name object))


(define (lesya:syntax:eval:check object)
  (or
   (and (not (list? object))
        (list 'not-a-constructor-for-eval object))
   (and (not (pair? object))
        (list 'null-for-eval object))
   (and (not (list-length= 2 object))
        (list 'bad-length-for-eval object))
   (and (not (equal? (car object) lesya:syntax:eval:name))
        (list 'wrong-constructor-for-eval object))))


(define (lesya:syntax:eval? object)
  (not (lesya:syntax:eval:check object)))


(define (lesya:syntax:eval:destruct object on-error)
  (define error (lesya:syntax:eval:check object))
  (when error
    (apply on-error error))

  (let ()
    (define-tuple (predicate eval) object)
    eval))


(define lesya:syntax:let:name
  'let)


(define (lesya:syntax:let:make supposition body)
  (list lesya:syntax:let:name supposition body))


(define (lesya:syntax:let:check object)
  (or
   (and (not (list? object))
        (list 'not-a-constructor-for-let object))
   (and (not (pair? object))
        (list 'null-for-let object))
   (and (not (list-length= 3 object))
        (list 'bad-length-for-let object))
   (and (not (equal? (car object) lesya:syntax:let:name))
        (list 'wrong-constructor-for-let object))))


(define (lesya:syntax:let? object)
  (not (lesya:syntax:let:check object)))


(define (lesya:syntax:let:destruct object on-error)
  (define error (lesya:syntax:let:check object))
  (when error
    (apply on-error error))

  (apply values (cdr object)))


(define lesya:syntax:begin:name
  'begin)


(define (lesya:syntax:begin:make . args)
  (cons 'begin args))
