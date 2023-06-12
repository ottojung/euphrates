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



;; https://en.wikipedia.org/wiki/Levenshtein_distance
(define (list-levenshtein-distance a b)
  (let lev ((a a) (b b))
    (cond
     ((null? b) (length a))
     ((null? a) (length b))
     ((equal? (car a) (car b)) (lev (cdr a) (cdr b)))
     (else
      (+ 1 (min (lev (cdr a) b)
                (lev a (cdr b))
                (lev (cdr a) (cdr b))))))))
