;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define olesya:environment
  (environment
   '(only (scheme base) unquote)
   '(rename (euphrates olesya-language)
            (olesya:language:term term)
            (olesya:language:rule rule)
            (olesya:language:define define)
            (olesya:language:begin begin)
            (olesya:language:let let)
            (olesya:language:= =)
            (olesya:language:map map)
            (olesya:language:eval eval)
            )))


(define (olesya:interpret program)
  (define escaped
    ;; Following escape is needed to not polute the toplevel environment of Olesya.
    ;; Zero at the end is just to allow `program` to end with `define`.
    `(let () ,program 0))

  (olesya:language:run
   (eval escaped olesya:environment)))
