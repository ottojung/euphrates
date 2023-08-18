;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (flatten-result result)
  (apply string-append
         (filter string? (list-collapse result))))

(define (do-transform flattened skiped result)
  (define re
    (let loop ((result result))
      (cond
       ((list? result)
        (if (pair? result)
            (let ()
              (define type (car result))
              (cond
               ((hashset-has? flattened type)
                (list (list (car result) (flatten-result (cdr result)))))
               ((hashset-has? skiped type)
                (list))
               (else
                (list (apply append (map loop result))))))
            (list result)))
       (else (list result)))))

  (if (null? re) re (car re)))

(define (lalr-parser/simple-transform-result flattened skiped result)
  (if (not (list? result)) result
      (do-transform flattened skiped result)))
