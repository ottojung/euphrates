;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic::binding::check binding)
  (unless (list? binding)
    (raisu* :from "labelinglogic"
            :type 'bad-binding
            :message "Binding in labelinglogic must be a list, but was not"
            :args (list binding)))

  (unless (list-length= 2 binding)
    (raisu* :from "labelinglogic"
            :type 'bad-binding-length
            :message "Binding in labelinglogic must have two components, but did not"
            :args (list binding)))

  (define-tuple (name expr) binding)

  (unless (symbol? name)
    (raisu* :from "labelinglogic"
            :type 'bad-expr
            :message "Binding name in labelinglogic must be a symbol, but was not"
            :args (list name binding)))

  (labelinglogic::expression::check expr)

  (define expr-type
    (labelinglogic::expression:type expr))

  (unless (member expr-type (list 'constant '=))
    (raisu* :from "labelinglogic"
            :type 'bad-expr
            :message "Binding in labelinglogic must evaluate refer a constant or a singleton set"
            :args (list expr binding)))

  )
