;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (lalr-parser/simple-do-inline inlined result)
  (if (not inlined) result
      (apply
       append
       (let loop ((result result))
         (cond
          ((and (pair? result)
                (hashset-has? inlined (car result)))
           (apply append (map loop (cdr result))))
          ((list? result)
           (list (apply append (map loop result))))
          (else (list result)))))))
