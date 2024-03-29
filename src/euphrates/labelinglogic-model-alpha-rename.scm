;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:alpha-rename taken-names-set model)
  (define all-taken-names
    (append
     (map (lambda (model-component)
            (define-tuple (class predicate) model-component)
            class)
          model)
     (if (hashset? taken-names-set)
         (hashset->list taken-names-set)
         taken-names-set)))

  (define (renamer constant)
    (if (unique-identifier? constant)
        (unique-identifier->symbol constant)
        constant))

  (with-unique-identifier-context
   :existing-names all-taken-names

   (labelinglogic:model:rename-constants
    renamer model)))
