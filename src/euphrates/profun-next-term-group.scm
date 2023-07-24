;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (profun-next/term-group iter)
  (define query (profun-iterator-query iter))
  (define assignments (profun-next iter))
  (if (or (not assignments)
          (profun-abort? assignments))
      assignments
      (map
       (lambda (qterm)
         (define predicate (car qterm))
         (define args (cdr qterm))
         (define new-args
           (map (lambda (arg) (assq-or arg assignments arg)) args))
         (cons predicate new-args))
       query)))
