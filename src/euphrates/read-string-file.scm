;;;; Copyright (C) 2020, 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (read-string-file path)
  (call-with-output-string
   (lambda (s)
     (call-with-input-file
         path
       (lambda (p)
         (let loop ()
           (define r (read-string 4096 p))
           (unless (eof-object? r)
             (display r s)
             (loop))))))))
