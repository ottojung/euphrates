;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:optimize/and-assuming-nointersect expr)
  (define type (labelinglogic:expression:type expr))
  (define args (labelinglogic:expression:args expr))

  (define (different-values-of-same-type? target-type expr-a expr-b)
    (define type-a (labelinglogic:expression:type expr-a))
    (define type-b (labelinglogic:expression:type expr-b))

    (and (equal? type-a target-type)
         (equal? type-b target-type)
         (not (labelinglogic:expression:syntactic-equal? expr-a expr-b))))

  (define (opposite-exprs? expr-a expr-b)
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

    (and (not (equal? negated-a? negated-b?))
         (labelinglogic:expression:syntactic-equal? inner-a inner-b)))

  (define (check-type expr)
    (define type (labelinglogic:expression:type expr))

    (unless (or (equal? type '=)
                (equal? type 'r7rs)
                (equal? type 'not)
                (equal? type 'tuple)
                (is-bottom? expr)
                (is-top? expr))
      (raisu* :from "labelinglogic:expression:optimize/and-assuming-nointersect"
              :type 'bad-expr-type
              :message (stringf "Expression type ~s not permitted here." (~a type))
              :args (list type expr))))

  (define (same-type-nonintersect? expr-a expr-b)
    (or (different-values-of-same-type? '= expr-a expr-b)
        (different-values-of-same-type? 'r7rs expr-a expr-b)
        ;; NOTE: there is no similar check for 'tuple because those can contain arbitrary (non-normalized) expressions as args.
        ;; TODO: add a similar check for 'tuple type.
        ))

  (define (different-type-nonintersect?/body expr-a expr-b)
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

    (or (and (equal? inner-type-a 'tuple)
             (not (equal? inner-type-b 'tuple)))

        (and (equal? type-a 'r7rs)
             (equal? type-b '=)
             (not
              (labelinglogic:expression:evaluate/r7rs
               expr-a (car (args-b)))))

        

        #f))

  (define (different-type-nonintersect? expr-a expr-b)
    (or (different-type-nonintersect?/body expr-a expr-b)
        (different-type-nonintersect?/body expr-b expr-a)))

  (define (null-exprs? expr-a expr-b)
    (check-type expr-a)
    (check-type expr-b)

    (or (opposite-exprs? expr-a expr-b)
        (same-type-nonintersect? expr-a expr-b)
        (different-type-nonintersect? expr-a expr-b)))

  (define bottom
    (labelinglogic:expression:make 'or '()))

  (define (is-bottom? expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))
    (and (equal? type 'or)
         (null? args)))

  (define (explode-bottom expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))
    (if (list-or-map is-bottom? args)
        bottom
        expr))

  (define (is-top? expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))
    (and (equal? type 'and)
         (null? args)))

  (define (remove-tops expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))
    (define new-args (filter (negate is-top?) args))
    (if (= (length args) (length new-args))
        expr
        (labelinglogic:expression:make type new-args)))

  (define (optimize expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (appcomp expr
             (list-idempotent labelinglogic:expression:syntactic-equal?)
             (list-annihilate null-exprs? bottom)
             explode-bottom
             remove-tops
             ))

  (unless (equal? type 'and)
    (raisu* :from "labelinglogic:expression:optimize/and-assuming-nointersect"
            :type 'unknown-expr-type
            :message (stringf "Expression type ~s not recognized" (~a type))
            :args (list type expr)))

  (apply-until-fixpoint optimize expr))
