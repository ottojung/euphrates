;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; FIXME: Returns things that are not actually referenced variables.
;;        Like in `(term P)` it will return `P`.
(define (olesya:syntax:get-referenced-names object)
  (define ret
    (stack-make))

  (let loop ((object object))
    (cond
     ((symbol? object)
      (stack-push! ret object))
     ((olesya:return:ok? object)
      (loop (olesya:return:ok:value object)))
     ((list? object)
      (unless (null? object)
        (for-each loop (cdr object))))))

  (reverse
   (stack->list ret)))
