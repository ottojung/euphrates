;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:optimize/assuming-nointersect-dnf expr)
  (debug "-------------------------------------------")

  (define (consume-subsets expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (define (fun expr-a expr-b)
      (cond
       ((labelinglogic:expression:is-subset?/assuming-nonintersect-dnf-clause expr-a expr-b) 'right)
       ((labelinglogic:expression:is-subset?/assuming-nonintersect-dnf-clause expr-b expr-a) 'left)
       (else 'skip)))

    (define new-args (list-idempotent fun args))
    (labelinglogic:expression:make type new-args))

  (define (remove-bottoms expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))
    (define new-args (filter (negate labelinglogic:expression:bottom?) args))
    (labelinglogic:expression:make type new-args))

  (define (explode-top expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))
    (if (list-or-map labelinglogic:expression:top? args)
        labelinglogic:expression:top
        expr))

  (define optimize-or/step
    (compose consume-subsets explode-top remove-bottoms))

  (define (optimize-or expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (if (equal? 'or type)
        (apply-until-fixpoint optimize-or/step expr)
        expr))

  (debugs expr)

  (define dnf
    (labelinglogic:expression:to-dnf expr))

  (debugs dnf)

  (define dnf-flat
    (labelinglogic:expression:sugarify dnf))

  (debugs dnf-flat)

  (exit 1)

  (define dnf-wrapped
    (if (equal? 'or (labelinglogic:expression:type dnf-flat))
        dnf-flat
        (labelinglogic:expression:make 'or (list dnf-flat))))

  (debugs dnf-wrapped)

  (define dnf*
    (optimize-or dnf-wrapped))

  (debugs dnf*)

  (define dnf*-wrapped
    (if (equal? 'or (labelinglogic:expression:type dnf*))
        dnf*
        (labelinglogic:expression:make 'or (list dnf*))))

  (debugs dnf*-wrapped)

  (define dnf*-args
    (labelinglogic:expression:args dnf*-wrapped))

  (debugs dnf*-args)

  (define simpl
    (labelinglogic:expression:make
     'or
     (map labelinglogic:expression:optimize/and-assuming-nointersect-dnf
          dnf*-args)))

  (debugs simpl)

  (define simpl*
    (optimize-or simpl))

  (debugs simpl*)

  (define no-singletons
    (labelinglogic:expression:optimize/singletons simpl*))

  (debugs no-singletons)

  no-singletons)
