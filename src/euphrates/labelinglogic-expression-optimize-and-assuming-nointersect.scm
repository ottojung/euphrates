;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:optimize/and-assuming-nointersect expr)
  ;; This function optimizes an 'and' expression by removing contradicting, redundant and non-intersecting components.
  ;;
  ;; The optimization process includes:
  ;;   - Removal of duplicate parts of the expression
  ;;   - Removal of parts that are negation of each other
  ;;   - Detection and handling of bottom expressions
  ;;   - Detection and handling of top expressions
  ;;   - Removal of parts that cannot intersect, either if they are of the same type or of different types
  ;;
  ;; The function keeps applying these transformations until the expression cannot be further optimized.
  ;;
  ;; It assumes the input expression is of 'and' type, and all of its elements are of types:
  ;;   - '=
  ;;   - 'r7rs
  ;;   - 'not
  ;;   - 'tuple
  ;; Or, in other words, ground terms + negated ground terms.
  ;;

  (define _0 (labelinglogic:expression:check expr))
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

    (and (not (equal? negated-a? negated-b?))
         (labelinglogic:expression:syntactic-equal? inner-a inner-b)))

  (define (check-type expr)
    (labelinglogic:expression:check expr)
    (define type (labelinglogic:expression:type expr))
    (unless (or (equal? type '=)
                (equal? type 'r7rs)
                (equal? type 'not)
                (equal? type 'tuple)
                (is-bottom? expr)
                (is-top? expr))
      (raisu* :from "labelinglogic:expression:optimize/and-assuming-nointersect"
              :type 'bad-sub-expr-type
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
    (define inner-tuple-a? (equal? 'tuple inner-type-a))
    (define inner-tuple-b? (equal? 'tuple inner-type-b))

    (or (not (equal? inner-tuple-a? inner-tuple-b?))

        (and (equal? type-a 'r7rs)
             (equal? type-b '=)
             (not
              (labelinglogic:expression:evaluate/r7rs
               expr-a (car args-b))))

        #f))

  (define (different-type-nonintersect? expr-a expr-b)
    (or (different-type-nonintersect?/body expr-a expr-b)
        (different-type-nonintersect?/body expr-b expr-a)))

  (define (null-exprs? expr-a expr-b)
    (or (opposite-exprs? expr-a expr-b)
        (same-type-nonintersect? expr-a expr-b)
        (different-type-nonintersect? expr-a expr-b)))

  (define (is-subset? expr-a expr-b)
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

    (or (and (equal? type-a 'r7rs)
             (equal? type-b '=)
             (labelinglogic:expression:evaluate/r7rs
              expr-a (car args-b)))

        (and (equal? type-b 'r7rs)
             (equal? type-a 'not)
             (equal? inner-type-a '=)
             (not
              (labelinglogic:expression:evaluate/r7rs
               expr-b (car inner-args-a))))))

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
    (if (list-or-map is-bottom? args) bottom expr))

  (define (is-top? expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))
    (and (equal? type 'and)
         (null? args)))

  (define (remove-tops expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))
    (define new-args (filter (negate is-top?) args))
    (labelinglogic:expression:make type new-args))

  (define (remove-idempotent expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))
    (define new-args (list-idempotent labelinglogic:expression:syntactic-equal? args))
    (labelinglogic:expression:make type new-args))

  (define (narrow expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (define default (make-unique))
    (define (fun expr-a expr-b)
      (cond
       ((is-subset? expr-a expr-b) expr-b)
       ((is-subset? expr-b expr-a) expr-a)
       (else default)))

    (define new-args (list-reduce/pairwise default fun args))
    (labelinglogic:expression:make type new-args))

  (define (handle-nulls expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))
    (define new-args (list-annihilate null-exprs? bottom args))
    (labelinglogic:expression:make type new-args))

  (define optimize
    (compose
     remove-idempotent
     narrow
     handle-nulls
     explode-bottom
     remove-tops
     ))

  (unless (equal? type 'and)
    (raisu* :from "labelinglogic:expression:optimize/and-assuming-nointersect"
            :type 'bad-expr-type
            :message (stringf "Expression must be of type 'and, but got type ~s expression." (~a type))
            :args (list type expr)))

  (for-each check-type args)

  (apply-until-fixpoint optimize expr))
