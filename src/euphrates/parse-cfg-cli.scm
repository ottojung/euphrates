;;;; Copyright (C) 2021, 2022  Otto Jung
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

;;
;; In this file we translate CFG-CLI definitions
;; into CFG-AST language.
;;

(define (CFG-CLI->CFG-AST body)
  (define translator
    (generic-bnf-tree->alist ":" "/"))

  (define body*
    (cons 'EUPHRATES-CFG-CLI-MAIN (cons ': body)))

  (when (null? body)
    (raisu* :from 'CFG-CLI->CFG-AST
            :type 'cfg-cli-must-be-non-empty
            :message "CFG CLI must be non-empty"
            :args (list)))

  (translator body*))
