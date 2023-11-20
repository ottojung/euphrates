;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:optimize/singletons expr)
  (define args (labelinglogic:expression:args expr))
  (if (list-singleton? args)
      (car args)
      expr))


(define (labelinglogic:expression:optimize/recurse-on-args expr)
  (define type (labelinglogic:expression:type expr))
  (define args (labelinglogic:expression:args expr))
  (cons type (map labelinglogic:expression:optimize args)))


(define (labelinglogic:expression:optimize/and+or expr)
  (define type (labelinglogic:expression:type expr))
  (define args (labelinglogic:expression:args expr))

  (labelinglogic:expression:optimize/singletons
   (let ()
     (define rec
       (map labelinglogic:expression:optimize args))

     (define dedup
       (list-deduplicate rec))

     (define new
       (labelinglogic:expression:make type dedup))

     (if (= (length rec) (length dedup)) new
         (labelinglogic:expression:optimize new)))))


(define (labelinglogic:expression:or->xor expr)
  (define type (labelinglogic:expression:type expr))
  (define args (labelinglogic:expression:args expr))

  (define grouped
    (list-group-by
     (lambda (expr)
       (equal? '= (labelinglogic:expression:type expr)))
     args))

  (labelinglogic:expression:make
   type
   (cons
    (labelinglogic:expression:make
     'xor
     (assq-or #t grouped '()))
    (assq-or #f grouped '()))))



(define (labelinglogic:expression:optimize/xor expr)
  ;; TODO: some optis.
  expr)


(define (labelinglogic:expression:optimize expr)
  (define type (labelinglogic:expression:type expr))

  (cond
   ((equal? type 'r7rs)
    expr)
   ;; (labelinglogic:expression:optimize/r7rs expr))

   ((equal? type 'not)
    (labelinglogic:expression:move-nots-down expr))

   ((equal? type 'tuple)
    (labelinglogic:expression:optimize/singletons
     (labelinglogic:expression:optimize/recurse-on-args expr)))

   ((member type (list 'and 'or))
    (labelinglogic:expression:optimize/and+or expr))

   ((member type (list 'xor))
    (labelinglogic:expression:optimize/xor expr))

   ((member type (list '= 'constant))
    expr)

   (else
    (raisu* :from "labelinglogic:expression:optimize"
            :type 'unknown-expr-type
            :message (stringf "Expression type ~s not recognized"
                              (~a type))
            :args (list type expr)))))
