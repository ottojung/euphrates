;;;; Copyright (C) 2024, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:interpret/first model)
  (define bindings
    (labelinglogic:model:bindings model))

  (define (constant-binding? binding)
    (define name (labelinglogic:binding:name binding))
    (define expr (labelinglogic:binding:expr binding))
    (define type (labelinglogic:expression:type expr))
    (equal? type 'constant))

  (define sorted-bindings
    (append
     (filter constant-binding? bindings)
     (filter (negate constant-binding?) bindings)))

  (define result-fun
    (labelinglogic:model:interpret sorted-bindings))

  (lambda (input)
    (define results (result-fun input))
    (if (null? results) #f
        (car results))))
