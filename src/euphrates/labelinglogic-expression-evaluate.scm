;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:evaluate/or model expr input)
  (define args (labelinglogic:expression:args expr))
  (list-or-map
   (lambda (arg)
     (labelinglogic:expression:evaluate model arg input))
   args))

(define (labelinglogic:expression:evaluate/constant model expr input)
  (define reference (assoc expr model))
  (unless reference
    (raisu* :from "labelinglogic:expression:evaluate"
            :type 'undefined-reference
            :message "Reference to nonexistant class"
            :args (list expr)))

  (define-tuple (class predicate) reference)
  (labelinglogic:expression:evaluate model predicate input))

(define (labelinglogic:expression:evaluate model expr input)
  (define type (labelinglogic:expression:type expr))

  (cond
   ((equal? type 'r7rs)
    (labelinglogic:expression:evaluate/r7rs model expr input))

   ((equal? type '=)
    (labelinglogic:expression:evaluate/equal model expr input))

   ((equal? type 'or)
    (labelinglogic:expression:evaluate/or model expr input))

   ((equal? type 'constant)
    (labelinglogic:expression:evaluate/constant model expr input))

   (else
    (raisu 'unknown-expr-type type expr))))
