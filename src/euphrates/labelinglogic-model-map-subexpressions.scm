;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:map-subexpressions fun model)
  (map
   (lambda (model-component)
     (define-tuple (class predicate) model-component)
     (define initialized-fun (fun class predicate))

     (define new
       (labelinglogic:expression:map-subexpressions
        initialized-fun predicate))

     (labelinglogic:binding:make class new))

   model))
