;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:map-subexpressions fun model)
  (map
   (lambda (model-component)
     (define-tuple (class predicate) model-component)
     (define initialized-fun (fun class predicate))

     (define new
       (let loop ((expr predicate))
         (define type (labelinglogic:expression:type expr))
         (define args (labelinglogic:expression:args expr))

         (cond
          ((member type (list 'or 'and 'not 'seq))
           (initialized-fun
            (cons type (map loop args))))

          ((member type (list '= 'constant 'r7rs))
           (initialized-fun expr))

          (else
           (raisu* :from "labelinglogic:model:map-subexpressions"
                   :type 'unknown-expr-type
                   :message (stringf "Expression type ~s not recognized"
                                     (~a type))
                   :args (list type expr))))))


     (labelinglogic:binding:make class new))

   model))
