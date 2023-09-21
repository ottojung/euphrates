;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (lalr-parser/simple-transform-result
         flattened joined skiped inlined transformed
         result)
  (appcomp result
           lalr-parser/simple-do-char->string
           (lalr-parser/simple-do-skips skiped)
           (lalr-parser/simple-do-flatten flattened)
           (lalr-parser/simple-do-transform transformed)
           (lalr-parser/simple-do-join joined)
           (lalr-parser/simple-do-inline inlined)))
