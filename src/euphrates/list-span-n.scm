;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



;; equivalent to (list-take-n n lst, list-drop-n n lst)
;; list may be shorter than n
(define (list-span-n n lst)
  (let loop ((n n) (lst lst) (buf '()))
    (if (or (zero? n) (null? lst))
        (values (reverse buf) lst)
        (loop (- n 1) (cdr lst) (cons (car lst) buf)))))
