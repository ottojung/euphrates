;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:inline-some predicate exported-names/set model)
  (labelinglogic:model:filter
   labelinglogic:binding:expr

   (labelinglogic:model:map-expressions
    (lambda (class expr)
      (lambda (expr)
        (cond
         ((predicate class expr)
          (labelinglogic:expression:inline-some  model expr))
         (else #f))))
    model)))
