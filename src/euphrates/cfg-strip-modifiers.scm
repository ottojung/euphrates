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
  (define-module (euphrates cfg-strip-modifiers)
    :export (CFG-strip-modifiers)
    :use-module ((euphrates compile-cfg-cli) :select (CFG-lang-modifier-char?))
    :use-module ((euphrates list-drop-while) :select (list-drop-while))
    )))

(define (CFG-strip-modifiers name)
  (list->string (reverse (list-drop-while CFG-lang-modifier-char? (reverse (string->list name))))))
