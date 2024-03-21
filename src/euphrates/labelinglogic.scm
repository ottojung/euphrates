;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:init
         model bindings)

  (labelinglogic:model:check model)

  (define classes/s
    (list->hashset
     (map car model)))

  (labelinglogic:bindings:check classes/s bindings)

  (debugs model)

  (define extended-model
    (labelinglogic:model:extend-with-bindings model bindings))

  (debugs extended-model)

  (define opt-model
    (labelinglogic:model:optimize-to-bindings extended-model bindings))

  (define duplicated-model
    (labelinglogic:model:duplicate-bindings opt-model bindings))

  ;; (debugs duplicated-model)

  (define flat-model
    (labelinglogic:model:flatten
     duplicated-model))

  (debugs flat-model)

  flat-model)
