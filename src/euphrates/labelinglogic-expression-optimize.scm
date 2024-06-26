;;;; Copyright (C) 2023, 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define (labelinglogic:expression:optimize/recurse-on-args expr)
  (define type (labelinglogic:expression:type expr))
  (define args (labelinglogic:expression:args expr))
  (cons type (map labelinglogic:expression:optimize args)))


(define (labelinglogic:expression:optimize/and+or expr)
  (define type (labelinglogic:expression:type expr))
  (define args (labelinglogic:expression:args expr))

  (define rec
    (map labelinglogic:expression:optimize args))

  (define dedup
    (apply-until-fixpoint
     (lambda (lst)
       (list-idempotent
        labelinglogic:expression:syntactic-equal?
        lst))
     rec))

  (define new
    (labelinglogic:expression:make type dedup))

  (if (= (length rec) (length dedup)) new
      (labelinglogic:expression:optimize new)))


(define (labelinglogic:expression:optimize/xor expr)
  ;; TODO: some optis.
  expr)


(define (labelinglogic:expression:optimize expr)
  (define type (labelinglogic:expression:type expr))

  (labelinglogic:expression:optimize/singletons
   (cond
    ((equal? type 'r7rs)
     expr)
    ;; (labelinglogic:expression:optimize/r7rs expr))

    ((equal? type 'not)
     (labelinglogic:expression:move-nots-down expr))

    ((equal? type 'list)
     (labelinglogic:expression:optimize/recurse-on-args expr))

    ((equal? type 'or)
     (labelinglogic:expression:optimize/and+or expr))

    ((member type (list 'and 'or))
     (labelinglogic:expression:optimize/and+or expr))

    ((member type (list 'xor))
     (labelinglogic:expression:optimize/xor expr))

    ((member type (list 'constant 'variable))
     expr)

    (else
     (raisu* :from "labelinglogic:expression:optimize"
             :type 'unknown-expr-type
             :message (stringf "Expression type ~s not recognized"
                               (~a type))
             :args (list type expr))))))
