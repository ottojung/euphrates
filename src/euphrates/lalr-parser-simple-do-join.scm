;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (lalr-parser/simple-do-join joined result)
  (let loop ((result result))
    (cond
     ((list? result)
      (if (pair? result)
          (let ()
            (define type (car result))
            (cond
             ((hashset-has? joined type)
              (list (car result)
                    (apply string-append
                           (lalr-parser/simple-flatten1 (cdr result)))))
             (else
              (map loop result))))
          result))
     (else result))))
