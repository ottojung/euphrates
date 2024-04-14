;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




(define (string-pad-L str size pad-char)
  (let* ((len (string-length str)))
    (if (>= len size) str
        (list->string
         (append (replicate (- size len) pad-char)
                 (string->list str))))))

(define (string-pad-R str size pad-char)
  (let* ((len (string-length str)))
    (if (>= len size) str
        (list->string
         (append (string->list str)
                 (replicate (- size len) pad-char))))))

