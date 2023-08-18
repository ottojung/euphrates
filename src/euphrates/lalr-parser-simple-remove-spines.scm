;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (lalr-parser/simple-remove-spines result)
  (let loop ((result result))
    (cond
     ((and (pair? result) (list-length= 2 result)
           (pair? (cadr result)) (list-length= 2 (cadr result))
           (equal? (car result) (car (cadr result))))
      (loop (list (car result) (cadr (cadr result)))))
     ((list? result)
      (map loop result))
     (else result))))
