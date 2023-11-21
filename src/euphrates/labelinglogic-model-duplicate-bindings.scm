;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:duplicate-equals model)
  (debugs model)

  (define to-duplicate
    (let ()
      (define S (make-hashset))
      (labelinglogic:model:map-subexpressions
       (const
        (lambda (expr)
          (define type (labelinglogic:expression:type expr))
          (when (equal? type '=)
            (hashset-add! S expr))
          expr))
       model)
      (hashset->list S)))

  (define (mapper expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (list-fold
     (acc expr)
     (to-add to-duplicate)

     (define value
       (car (labelinglogic:expression:args to-add)))

     (cond
      ((and (equal? type 'r7rs)
            (labelinglogic:expression:evaluate/r7rs expr value))
       (labelinglogic:expression:make 'or (list expr to-add)))
      (else expr))))

  (define duplicated-model
    (labelinglogic:model:map-subexpressions
     (const mapper) model))

  (debugs duplicated-model)

  duplicated-model)
