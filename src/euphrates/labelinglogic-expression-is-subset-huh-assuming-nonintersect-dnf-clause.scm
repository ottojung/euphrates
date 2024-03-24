;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:is-subset?/assuming-nonintersect-dnf-clause expr-small expr-big)
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

    (define (ands-subset? args-small args-big)
      (list-and-map
       (lambda (arg-big)
         (list-or-map
          (lambda (arg-small)
            (loop arg-small arg-big))
          args-small))
       args-big))

    (cond
     ((labelinglogic:expression:top? expr-big) #t)
     ((labelinglogic:expression:syntactic-equal? expr-small expr-big) #t)

     ((equal? type-small 'and)
      (if (equal? type-big 'and)
          (ands-subset? args-small args-big)
          (ands-subset? args-small (list expr-big))))

     ((equal? type-small '=)
      (or
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

       (and (equal? type-small '=)
            (equal? type-big 'not)
            (equal? inner-type-big '=)
            (not (equal? (car inner-smallrgs-small)
                         (car inner-smallrgs-big))))))

     ((equal? type-small 'r7rs)
      (or
       (and (equal? type-small 'r7rs)
            (equal? type-big 'not)
            (equal? inner-type-big '=)
            (not
             (labelinglogic:expression:evaluate/r7rs
              expr-small (car inner-smallrgs-big))))

       (and (equal? type-small 'r7rs)
            (equal? type-big 'not)
            (equal? inner-type-big 'r7rs)
            (not (equal? (car inner-smallrgs-small)
                         (car inner-smallrgs-big))))))

     ((equal? type-small 'not)
      (and (equal? inner-type-small 'r7rs)
           (equal? type-big 'not)
           (equal? inner-type-big '=)
           (loop inner-big inner-small)))

     ((equal? type-small 'tuple)
      (and (equal? type-big 'tuple)
           (equal? (length args-small) (length args-big))
           (list-and-map
            (lambda (p) (loop (car p) (cdr p)))
            (list-zip args-small args-big))))

     (else
      (raisu* :from "labelinglogic:expression:is-subset?/semiground"
              :type 'bad-sub-expr-type
              :message (stringf "Expression type ~s not permitted here." (~a type-small))
              :args (list type-small expr-small))))))
