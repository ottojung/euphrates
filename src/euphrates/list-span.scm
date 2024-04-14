;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




;; equivalent to (take n lst, drop n lst)
;; list must be of length at least n
(define (list-span n lst)
  (let loop ((n n) (lst lst) (buf '()))
    (if (zero? n)
        (values (reverse buf) lst)
        (if (null? lst)
            (raisu 'list-span-too-short "List must be longer than" n)
            (loop (- n 1) (cdr lst) (cons (car lst) buf))))))
