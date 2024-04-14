;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (list-split-on predicate lst)
  (let loop ((lst lst)
             (buf '())
             (ret '())
             (last-split? #f))
    (cond
     ((null? lst)
      (if (or last-split? (not (null? buf)))
          (reverse (cons (reverse buf) ret))
          (reverse ret)))
     ((predicate (car lst))
      (loop (cdr lst) '()
            (cons (reverse buf) ret)
            #t))
     (else
      (loop (cdr lst) (cons (car lst) buf) ret #f)))))
