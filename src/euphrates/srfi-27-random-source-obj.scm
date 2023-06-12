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


;; For the use exclusively in srfi-27-base-generator.scm



(define (:random-source-make a0 a1 a2 a3 a4 a5)
  (vector a0 a1 a2 a3 a4 a5))

(define (:random-source? s)
  (and (vector? s)
       (= 6 (vector-length s))))

(define (:random-source-state-ref s)
  (vector-ref s 0))

(define (:random-source-state-set! s)
  (vector-ref s 1))

(define (:random-source-randomize! s)
  (vector-ref s 2))

(define (:random-source-pseudo-randomize! s)
  (vector-ref s 3))

(define (:random-source-make-integers s)
  (vector-ref s 4))

(define (:random-source-make-reals s)
  (vector-ref s 5))

(define (:random-source-current-time)
  (time-get-fast-parameterizeable-timestamp))
