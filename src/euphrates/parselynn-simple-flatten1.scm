;;;; Copyright (C) 2023, 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:simple:flatten1 result)
  (define ret (stack-make))

  (let loop ((result result))
    (if (pair? result)
        (for-each
         loop (if (symbol? (car result))
                  (cdr result)
                  result))
        (stack-push! ret result)))

  (reverse (stack->list ret)))
