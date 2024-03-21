;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-syntax labelinglogic:model:assoc-or
  (syntax-rules ()
    ((_ variable-name model default)
     (car (assoc-or variable-name model default)))

    ((_ variable-name model)
     (let ((name variable-name)
           (model* model))
       (labelinglogic:model:assoc-or
        name model*
        (raisu* :from "labelinglogic:model:assoc-or"
                :type 'model-assoc-or-error
                :message (stringf "Expression named ~s is abscent in the model." name)
                :args (list name model*)))))))
