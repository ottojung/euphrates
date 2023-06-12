;;;; Copyright (C) 2022  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; version 3 of the License.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.




(define (vector-random-shuffle! v)
  (let ((n (- (vector-length v) 1)))
    (let loop ((i 0))
      (if (> i n) (when #f #t)
          (let* ((pos (+ i (big-random-int (+ 1 (- n i)))))
                 (save (vector-ref v pos)))
            (vector-set! v pos (vector-ref v i))
            (vector-set! v i save)
            (loop (+ 1 i)))))))
