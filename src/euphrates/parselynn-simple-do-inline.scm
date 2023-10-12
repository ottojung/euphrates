;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn/simple-do-inline inlined result)
  (define (loop result)
    (cond
     ((and (pair? result)
           (hashset-has? inlined (car result)))
      (main (cdr result)))
     ((list? result)
      (list (main result)))
     (else (list result))))

  (define (main result)
    (apply append (map loop result)))

  (cond
   ((not inlined) result)
   ((list? result) (main result))
   (else result)))
