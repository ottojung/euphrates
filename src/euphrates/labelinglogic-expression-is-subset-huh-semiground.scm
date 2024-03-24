;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:is-subset?/semiground expr-small expr-big)
  (let loop ((expr-small expr-small)
             (expr-big expr-big))

    (define type-small (labelinglogic:expression:type expr-small))
    (define type-big (labelinglogic:expression:type expr-big))
    (define args-small (labelinglogic:expression:args expr-small))
    (define args-big (labelinglogic:expression:args expr-big))
    (define negated-small? (equal? 'not type-small))
    (define negated-big? (equal? 'not type-big))
    (define inner-small (if negated-small? (car args-small) expr-small))
    (define inner-big (if negated-big? (car args-big) expr-big))
    (define inner-type-small (labelinglogic:expression:type inner-small))
    (define inner-type-big (labelinglogic:expression:type inner-big))
    (define inner-smallrgs-small (labelinglogic:expression:args inner-small))
    (define inner-smallrgs-big (labelinglogic:expression:args inner-big))

    (or
     (labelinglogic:expression:top? expr-big)

     (labelinglogic:expression:syntactic-equal? expr-small expr-big)

     (and (equal? type-small '=)
          (equal? type-big 'r7rs)
          (labelinglogic:expression:evaluate/r7rs
           expr-big (car args-small)))

     (and (equal? type-small '=)
          (equal? type-big 'not)
          (equal? inner-type-big 'r7rs)
          (not
           (labelinglogic:expression:evaluate/r7rs
            inner-big (car args-small))))

     (and (equal? type-small 'r7rs)
          (equal? type-big 'not)
          (equal? inner-type-big '=)
          (not
           (labelinglogic:expression:evaluate/r7rs
            expr-small (car inner-smallrgs-big))))

     (and (equal? type-small '=)
          (equal? type-big 'not)
          (equal? inner-type-big '=)
          (not (equal? (car inner-smallrgs-small)
                       (car inner-smallrgs-big))))

     (and (equal? type-small 'r7rs)
          (equal? type-big 'not)
          (equal? inner-type-big 'r7rs)
          (not (equal? (car inner-smallrgs-small)
                       (car inner-smallrgs-big))))

     (and (equal? type-big 'not)
          (equal? inner-type-big '=)
          (equal? type-small 'not)
          (equal? inner-type-small 'r7rs)
          (loop inner-big inner-small))

     )))
