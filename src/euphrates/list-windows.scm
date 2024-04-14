;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




;; Returns list of views of a "sliding window"
;; `(length lst)` must be larger than `window-size!`
(define (list-windows window-size lst)
  (define-values (start rest) (list-span window-size lst))
  (let loop ((lst rest) (cur start) (ret (list start)))
    (if (null? lst) (reverse ret)
        (let* ((x (car lst))
               (new-cur (append (cdr cur) (list x))))
          (loop (cdr lst)
                new-cur
                (cons new-cur ret))))))
