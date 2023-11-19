;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:try-simplify-subground-term expr)
  (define type (labelinglogic:expression:type expr))
  (define args (labelinglogic:expression:args expr))

  (cond
   ((member type (list '= 'r7rs 'constant 'tuple 'not))
    expr)

   ((equal? type 'and)
    (let loop ((args args))
      (define-tuple (A-expr B-expr) args)

      (define A-type (labelinglogic:expression:type A-expr))
      (define A-args (labelinglogic:expression:args A-expr))
      (define B-type (labelinglogic:expression:type B-expr))
      (define B-args (labelinglogic:expression:args B-expr))

      (cond
       ((and (equal? A-type B-type)
             (member A-type (list '= 'r7rs 'tuple)))

        (if (equal? A-expr B-expr) A-expr
            (labelinglogic:expression:make 'or '())))

       ((and (member A-type (list 'constant))
             (equal? A-expr B-expr))
        A-expr)

       ((and (equal? A-type 'r7rs)
             (equal? B-type '=))

        (if (labelinglogic:expression:evaluate/r7rs A-expr (car B-args))
            A-expr
            (labelinglogic:expression:evaluate/r7rs 'or '())))

       ((and (equal? A-type '=)
             (equal? B-type 'r7rs))
        (loop (list B-expr A-expr)))

       (else #f))))


   ((equal? type 'or)
    (let loop ((args args))
      (define-tuple (A-expr B-expr) args)
      (define A-type (labelinglogic:expression:type A-expr))
      (define A-args (labelinglogic:expression:args A-expr))
      (define B-type (labelinglogic:expression:type B-expr))
      (define B-args (labelinglogic:expression:args B-expr))

      (cond
       ((and (equal? A-type B-type)
             (member A-type (list '= 'r7rs 'tuple 'constant)))

        (if (equal? A-expr B-expr)
            A-expr
            (labelinglogic:expression:make 'xor args)))

       ((and (equal? A-type 'r7rs)
             (equal? B-type '=))

        (if (labelinglogic:expression:evaluate/r7rs A-expr (car B-args))
            A-expr #f))

       ((and (equal? A-type '=)
             (equal? B-type 'r7rs))
        (loop (list B-expr A-expr)))

       (else #f))))


   ((equal? type 'xor)
    (let loop ((args args))
      (define-tuple (A-expr B-expr) args)
      (define A-type (labelinglogic:expression:type A-expr))
      (define A-args (labelinglogic:expression:args A-expr))
      (define B-type (labelinglogic:expression:type B-expr))
      (define B-args (labelinglogic:expression:args B-expr))

      (cond
       ((and (equal? A-type B-type)
             (member A-type (list '= 'r7rs 'tuple 'constant)))

        (if (equal? A-expr B-expr)
            (labelinglogic:expression:make 'or '())
            #f))

       (else #f))))


   (else
    (raisu* :from "labelinglogic:expression:simplify-subground-term"
            :type 'unknown-expr-type
            :message (stringf "Expression type ~s not recognized"
                              (~a type))
            :args (list type expr)))))
