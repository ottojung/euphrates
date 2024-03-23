;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:optimize/assuming-nointersect-dnf universe expr)
  (define (is-subset? expr-a expr-b)
    (list-and-map
     (lambda (sub-expr-a)
       (list-or-map
        (lambda (sub-expr-b)
          (labelinglogic:expression:syntactic-equal?
           sub-expr-a sub-expr-b))
        expr-b))
     expr-a))

  (define (consume-subsets expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (define (fun expr-a expr-b)
      (cond
       ((is-subset? expr-a expr-b) 'left)
       ((is-subset? expr-b expr-a) 'right)
       (else 'skip)))

    (define new-args (list-idempotent fun args))
    (labelinglogic:expression:make type new-args))

  (define (remove-bottoms expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))
    (define new-args (filter (negate labelinglogic:expression:bottom?) args))
    (labelinglogic:expression:make type new-args))

  (define optimize-or/step
    (compose consume-subsets remove-bottoms))

  (define (optimize-or expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (if (equal? 'or type)
        (apply-until-fixpoint optimize-or/step expr)
        expr))

  (define dnf
    (labelinglogic:expression:to-dnf expr))

  (define dnf*
    (optimize-or
     (if (equal? 'or (labelinglogic:expression:type dnf))
         dnf
         (labelinglogic:expression:make 'or (list dnf)))))

  (define dnf*-args
    (labelinglogic:expression:args dnf*))

  (define simpl
    (optimize-or
     (labelinglogic:expression:make
      'or
      (map labelinglogic:expression:optimize/and-assuming-nointersect-dnf
           dnf*-args))))

  (labelinglogic:expression:optimize/singletons
   simpl*))
