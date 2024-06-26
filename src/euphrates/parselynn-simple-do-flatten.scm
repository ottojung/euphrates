;;;; Copyright (C) 2023, 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:simple:do-flatten flattened result)
  (if (not flattened) result
      (apply
       append
       (let loop ((parent #f) (result result))
         (define new-parent (and (pair? result) (car result)))

         (cond
          ((and (pair? result)
                (equal? new-parent parent)
                (hashset-has? flattened parent))
           (apply append (map (comp (loop new-parent)) (cdr result))))
          ((list? result)
           (list (apply append (map (comp (loop new-parent)) result))))
          (else (list result)))))))
