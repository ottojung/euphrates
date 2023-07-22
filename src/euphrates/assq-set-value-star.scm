;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (assq-set-value* keylist value alist)
  (let loop ((keylist keylist)
             (current alist))
    (cond
     ((null? keylist) value)
     (else
      (let* ((key (car keylist))
             (rec (if (list? current) current '()))
             (got (assq-or key rec '())))
        (assq-set-value
         key
         (loop (cdr keylist) got)
         rec))))))
