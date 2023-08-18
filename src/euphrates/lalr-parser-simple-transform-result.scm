;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (join-result result)
  (apply string-append
         (filter string? (list-collapse result))))

(define (do-transform joined result)
  (let loop ((result result))
    (cond
     ((list? result)
      (if (pair? result)
          (let ()
            (define type (car result))
            (cond
             ((hashset-has? joined type)
              (list (car result) (join-result (cdr result))))
             (else (map loop result))))
          result))
     (else result))))

(define (lalr-parser/simple-transform-result joined result)
  (if (not (list? result)) result
      (do-transform joined result)))
