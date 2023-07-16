;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (list-zip-longest fill-value a b)
  (let loop ((a a) (b b) (buf '()))
    (if (and (null? a) (null? b))
        (reverse buf)
        (let ((a* (if (null? a) (list fill-value) a))
              (b* (if (null? b) (list fill-value) b)))
          (loop (cdr a*) (cdr b*)
                (cons (cons (car a*) (car b*)) buf))))))
