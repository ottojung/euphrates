;;;; Copyright (C) 2020, 2021  Otto Jung
;;;;
;;;; This program is free software; you can redistribute it and/or modify
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

%run guile

%var profun-op-divisible

%use (profun-op-lambda) "./profun-op-lambda.scm"

(define profun-op-divisible
  (profun-op-lambda
   ctx (y x)
   (define last (or ctx 1))
   (if x
       (and (not (= 0 x))
            (= 0 (remainder y x)))
       (and (< last y)
            (let loop ((i last) (cnt 0))
              (if (= 0 (remainder y i))
                  (cons (list #t i) (+ i 1))
                  (loop (+ 1 i) cnt)))))))
