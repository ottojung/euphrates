;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define lesya:environment
  (environment
   '(only (scheme base) unquote)
   '(rename (euphrates lesya-language)
            (lesya:language:axiom axiom)
            (lesya:language:alpha alpha)
            (lesya:language:beta beta)
            (lesya:language:define define)
            (lesya:language:apply apply)
            (lesya:language:begin begin)
            (lesya:language:let let)
            (lesya:language:when when)
            (lesya:language:map map)
            (lesya:language:eval eval)
            (lesya:language:list list)
            )))

(define (lesya:interpret program)
  (define escaped
    ;; Following escape is needed to not polute the toplevel environment of Lesya.
    ;; Zero at the end is just to allow `program` to end with `define`.
    `(let () ,program 0))

  (lesya:language:run
   (eval escaped lesya:environment)))
