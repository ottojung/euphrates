;;;; Copyright (C) 2021, 2022, 2023  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; version 3 of the License.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(cond-expand
 (guile
  (define-module (euphrates cfg-parse-modifiers)
    :export (CFG-parse-modifiers)
    :use-module ((euphrates compile-cfg-cli) :select (CFG-lang-modifier-char?))
    :use-module ((euphrates list-span-while) :select (list-span-while))
    :use-module ((euphrates tilda-a) :select (~a))
    )))

(define (CFG-parse-modifiers name)
  (define-values (actual-name modifier-string)
    (list-span-while (negate CFG-lang-modifier-char?)
                     (string->list (~a name))))

  (values (list->string actual-name)
          (list->string modifier-string)))
