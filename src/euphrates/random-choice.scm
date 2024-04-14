;;;; Copyright (C) 2020, 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




(define (random-choice len alphabet#vector)
  (let ((size (vector-length alphabet#vector)))
    (let loop ((len len) (buf '()))
      (if (<= len 0) buf
          (loop (- len 1)
                (cons (vector-ref alphabet#vector (big-random-int size))
                      buf))))))

