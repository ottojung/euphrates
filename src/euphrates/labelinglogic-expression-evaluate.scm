;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:evaluate model expr input)
  (let loop ((expr expr))
    (define type (labelinglogic:expression:type expr))

    (define (labelinglogic:expression:evaluate/or model expr input)
      (define args (labelinglogic:expression:args expr))
      (list-or-map loop args))

    (define (labelinglogic:expression:evaluate/and model expr input)
      (define args (labelinglogic:expression:args expr))
      (list-and-map loop args))

    (define (labelinglogic:expression:evaluate/not model expr input)
      (define args (labelinglogic:expression:args expr))
      (not (loop (car args))))

    (define (labelinglogic:expression:evaluate/constant model expr input)
      (define reference
        (labelinglogic:model:assoc-or
         expr model
         (raisu* :from "labelinglogic:expression:evaluate"
                 :type 'undefined-reference
                 :message "Reference to nonexistant class"
                 :args (list expr))))

      (define predicate (labelinglogic:binding:expr reference))
      (loop predicate))

    (cond
     ((equal? type 'r7rs)
      (labelinglogic:expression:evaluate/r7rs expr input))

     ((equal? type '=)
      (labelinglogic:expression:evaluate/equal model expr input))

     ((equal? type 'or)
      (labelinglogic:expression:evaluate/or model expr input))

     ((equal? type 'and)
      (labelinglogic:expression:evaluate/and model expr input))

     ((equal? type 'not)
      (labelinglogic:expression:evaluate/not model expr input))

     ((equal? type 'constant)
      (labelinglogic:expression:evaluate/constant model expr input))

     (else
      (raisu 'unknown-expr-type type expr)))))
