;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




(define (linear-interpolate-1d start end t)
  (unless (and (number? t) (<= 0 t) (<= t 1))
    (raisu 't-must-be-a-number-in-range-0-1 start end t))

  (+ (* (- 1 t) start) (* end t)))


(define (linear-interpolate-2d start end t)
  (define x1 (car start))
  (define x2 (car end))
  (define y1 (cdr start))
  (define y2 (cdr end))

  (unless (and (number? t) (<= 0 t) (<= t 1))
    (raisu 't-must-be-a-number-in-range-0-1 start end t))

  (cons (linear-interpolate-1d x1 x2 t)
        (linear-interpolate-1d y1 y2 t)))



