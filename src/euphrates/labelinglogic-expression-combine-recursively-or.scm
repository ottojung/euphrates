;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:combine-recursively/or expr)
  (define type (labelinglogic:expression:type expr))
  (define args (labelinglogic:expression:args expr))

  (define grouped
    (list-group-by
     (lambda (expr)
       (labelinglogic:expression:type expr))
     args))

  (define (combine-r7rs left right)
    (define-tuple (left-e)
      (labelinglogic:expression:args left))
    (define-tuple (right-e)
      (labelinglogic:expression:args right))

    (list 'r7rs `(lambda (c) (or (,left-e c) (,right-e c)))))

  (define combined
    (apply
     append
     (map
      (lambda (g)
        (define-pair (type exprs) g)

        (cond
         ((equal? 'r7rs type)
          (list
           (list-fold
            (acc '())
            (cur exprs)
            (if (null? acc) cur
                (combine-r7rs acc cur)))))

         (else exprs)))

      grouped)))

  (cons type combined))
