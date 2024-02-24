;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:optimize/and-assuming-nointersect expr)
  (define type (labelinglogic:expression:type expr))
  (define args (labelinglogic:expression:args expr))

  (define (different-
    (define type-a (labelinglogic:expression:type expr-a))
    (define type-b (labelinglogic:expression:type expr-b))
  

  (define (opposite-exprs? expr-a expr-b)
    (define type-a (labelinglogic:expression:type expr-a))
    (define type-b (labelinglogic:expression:type expr-b))

    (cond
     ((and (equal? type-a 'not)
           (equal? type-b 'not))
      #f)

     ((equal? type-a 'not)
      (let ()
        (define-tuple (inner) (labelinglogic:expression:args type-a))
        (labelinglogic:expression:syntactic-equal? inner expr-b)))

     ((equal? type-b 'not)
      (let ()
        (define-tuple (inner) (labelinglogic:expression:args type-b))
        (labelinglogic:expression:syntactic-equal? expr-a inner)))

     (else
      #f)))

  (define (obviously-nonintersect? expr-a expr-b)
    (define type-a (labelinglogic:expression:type expr-a))
    (define type-b (labelinglogic:expression:type expr-b))

    (unless (or (equal? type-a 'constant)
                (equal? type-a 'r7rs)
                (equal? type-a '=))
    
    (or (different-constants? expr-a expr-b)
        (different-r7rs? expr-a expr-b)
        (different-tuples? expr-a expr-b)))

  (define (null-exprs? expr-a expr-b)
    (or (opposite-exprs? expr-a expr-b)
        (obviously-nonintersect? expr-a expr-b)))

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

  (define (optimize expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (appcomp expr
             (list-idempotent labelinglogic:expression:syntactic-equal?)
             (list-annihilate null-exprs? bottom)
             explode-bottom
             ))

  (unless (equal? type 'and)
    (raisu* :from "labelinglogic:expression:optimize/and-assuming-nointersect"
            :type 'unknown-expr-type
            :message (stringf "Expression type ~s not recognized"
                              (~a type))
            :args (list type expr)))

  (apply-until-fixpoint optimize expr))
