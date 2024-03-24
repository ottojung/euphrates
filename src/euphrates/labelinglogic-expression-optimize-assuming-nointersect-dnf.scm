;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:optimize/assuming-nointersect-dnf dnf)
  (debug "-------------------------------------------")

  (define (check-type expr)
    (define _531 (labelinglogic:expression:check expr))
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (unless (or (equal? type '=)
                (equal? type 'r7rs)
                (and (equal? type 'not)
                     (for-each check-type args))
                (and (equal? type 'tuple)
                     (for-each check-type args))
                (and (equal? type 'and)
                     (for-each check-type args))
                (labelinglogic:expression:bottom? expr)
                (labelinglogic:expression:top? expr))

      (raisu* :from "labelinglogic:expression:optimize/assuming-nointersect-dnf"
              :type 'bad-sub-expr-type
              :message (stringf "Expression type ~s not permitted here." (~a type))
              :args (list type expr))))

  (define (consume-subsets expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (define (fun expr-a expr-b)
      (cond
       ((labelinglogic:expression:is-subset?/assuming-nonintersect-dnf-term expr-a expr-b) 'right)
       ((labelinglogic:expression:is-subset?/assuming-nonintersect-dnf-term expr-b expr-a) 'left)
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

  (debugs dnf)

  (define dnf-flat
    (labelinglogic:expression:sugarify dnf))

  (debugs dnf-flat)

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

  (define _41328390
    (for-each check-type dnf*-args))

  (debugs dnf*-args)

  (define (maybe-optimize-and expr)
    (define type (labelinglogic:expression:type expr))
    (if (equal? type 'and)
        (labelinglogic:expression:optimize/and-assuming-nointersect-dnf expr)
        expr))

  (define simpl
    (labelinglogic:expression:make
     'or (map maybe-optimize-and dnf*-args)))

  (debugs simpl)

  (define simpl*
    (optimize-or simpl))

  (debugs simpl*)

  (define no-singletons
    (labelinglogic:expression:optimize/singletons simpl*))

  (debugs no-singletons)

  no-singletons)
