;;;; Copyright (C) 2022, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



(define (assoc-set-value key value alist0)
  (let loop ((alist alist0))
    (if (null? alist)
        `((,key . ,value))
        (let ((x (car alist)))
          (if (equal? key (car x))
              (cons `(,key . ,value) (cdr alist))
              (cons x (loop (cdr alist))))))))
