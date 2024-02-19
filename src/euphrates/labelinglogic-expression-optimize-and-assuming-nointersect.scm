;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:optimize/and-assuming-nointersect expr)
  (define type (labelinglogic:expression:type expr))
  (define args (labelinglogic:expression:args expr))

  (define (opposite-exprs? expr-a expr-b)
    (define type-a (labelinglogic:expression:type expr-a))
    (define type-b (labelinglogic:expression:type expr-b))
    (cond
     ((and (equal? type-a 'not)
           (equal? type-b 'not))
      (not (labelinglogic:expression:syntactic-equal? expr-a expr-b)))

     ((equal? type-a 'not)
      (let ()
        (define-tuple (inner) (labelinglogic:expression:args type-a))
        (labelinglogic:expression:syntactic-equal? inner expr-b)))

     ((equal? type-b 'not)
      (let ()
        (define-tuple (inner) (labelinglogic:expression:args type-b))
        (labelinglogic:expression:syntactic-equal? expr-a inner)))

     (else (not (labelinglogic:expression:syntactic-equal? expr-a expr-b)))))

  (define bottom
    (labelinglogic:expression:make 'or '()))

  (define (optimize expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (appcomp expr
             (list-idempotent equal?)
             (list-annihilate opposite-exprs? bottom)
             ))

  (unless (equal? type 'and)
    (raisu* :from "labelinglogic:expression:optimize/and-assuming-nointersect"
            :type 'unknown-expr-type
            :message (stringf "Expression type ~s not recognized"
                              (~a type))
            :args (list type expr)))

  (apply-until-fixpoint optimize))
