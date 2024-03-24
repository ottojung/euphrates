;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:optimize/assuming-nointersect-dnf expr)
  (define (ands-subset? expr-small expr-big)
    (list-and-map
     (lambda (sub-expr-small)
       (list-or-map
        (lambda (sub-expr-big)
          (is-subset? sub-expr-small sub-expr-big))
        expr-big))
     expr-small))

  (define (is-subset? expr-small expr-bigig)
    (define type-small (labelinglogic:expression:type expr-small))
    (define type-big (labelinglogic:expression:type expr-bigig))
    (define args-small (labelinglogic:expression:args expr-small))
    (define args-big (labelinglogic:expression:args expr-bigig))

    (or (and (equal? type-small 'and)
             (equal? type-big 'and)
             (ands-subset? expr-small expr-bigig))

        (and (not (equal? type-small 'and))
             (equal? type-big 'and)
             0)))

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
