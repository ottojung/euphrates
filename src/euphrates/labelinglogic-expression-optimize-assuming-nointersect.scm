;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:optimize/assuming-nointersect expr)
  (define (is-and-subset? expr-a expr-b)
    (define type-a (labelinglogic:expression:type expr-a))
    (define type-b (labelinglogic:expression:type expr-b))
    (define args-a (labelinglogic:expression:args expr-a))
    (define args-b (labelinglogic:expression:args expr-b))
    (define negated-a? (equal? 'not type-a))
    (define negated-b? (equal? 'not type-b))
    (define inner-a (if negated-a? (car args-a) expr-a))
    (define inner-b (if negated-b? (car args-b) expr-b))
    (define inner-type-a (labelinglogic:expression:type inner-a))
    (define inner-type-b (labelinglogic:expression:type inner-b))
    (define inner-args-a (labelinglogic:expression:args inner-a))
    (define inner-args-b (labelinglogic:expression:args inner-b))
    (define inner-tuple-a? (equal? 'tuple inner-type-a))
    (define inner-tuple-b? (equal? 'tuple inner-type-b))

    (or
     (labelinglogic:expression:top? expr-a)

     (labelinglogic:expression:syntactic-equal? expr-a expr-b)

     (and (equal? type-a '=)
          (equal? type-b 'r7rs)
          (labelinglogic:expression:evaluate/r7rs
           expr-b (car args-a)))

     (and (equal? type-a '=)
          (equal? type-b 'not)
          (equal? inner-type-b 'r7rs)
          (not
           (labelinglogic:expression:evaluate/r7rs
            (car args-b) (car args-a))))

     (and (equal? type-a 'r7rs)
          (equal? type-b 'not)
          (equal? inner-type-b '=)
          (not
           (labelinglogic:expression:evaluate/r7rs
            expr-a (car inner-args-b))))

     (and (equal? type-a '=)
          (equal? type-b 'not)
          (equal? inner-type-b '=)
          (not (equal? (car inner-args-a)
                       (car inner-args-b))))

     (and (equal? type-a 'r7rs)
          (equal? type-b 'not)
          (equal? inner-type-b 'r7rs)
          (not (equal? (car inner-args-a)
                       (car inner-args-b))))

     ))

  (define (explode-bottom expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))
    (if (list-or-map labelinglogic:expression:bottom? args)
        labelinglogic:expression:bottom
        expr))

  (define (remove-tops expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))
    (define new-args (filter (negate labelinglogic:expression:top?) args))
    (labelinglogic:expression:make type new-args))

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

  (define (optimize-or expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (if (equal? 'or type)
        (labelinglogic:expression:make
         dnf-type
         (list-idempotent/left
          labelinglogic:expression:equal?/and-assuming-nointersect
          args))
        expr))

  (define dnf
    (labelinglogic:expression:to-dnf expr))

  (define dnf*
    (if (equal? 'or (labelinglogic:expression:type dnf))
        dnf
        (labelinglogic:expression:make 'or (list dnf))))

  (define dnf*-args
    (labelinglogic:expression:args dnf*))

  (define simpl
    (optimize-or
     (labelinglogic:expression:make
      'or
      (map labelinglogic:expression:optimize/and-assuming-nointersect
           dnf*-args))))

  (labelinglogic:expression:optimize/singletons
   simpl*))
