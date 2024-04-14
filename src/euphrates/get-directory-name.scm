;;;; Copyright (C) 2020, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (get-directory-name path)
  (define (root? path)
    (string-every
     (lambda (c) (equal? #\/ c)) path))

  (cond
   ((string-null? path) ".")
   ((root? path) "/")
   (else
    (let* ((trimmed (string-trim-right path #\/))
           (ri (string-index-right trimmed #\/)))
      (if ri
          (let ((sub (substring trimmed 0 ri)))
            (if (root? sub) "/"
                (string-trim-right sub #\/)))
          ".")))))
