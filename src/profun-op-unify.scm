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

%var profun-op-unify

%use (profun-op-lambda) "./profun-op-lambda.scm"
%use (profun-variable-equal?) "./profun-variable-equal-q.scm"
%use (raisu) "./raisu.scm"

(define profun-op-unify
  (profun-op-lambda
   ctx (x y)
   (case (profun-variable-equal? x y)
     ((#t) #t)
     ((#f) #f)
     ((x-false) (cons (list y #t) #f))
     ((y-false) (cons (list #t x) #f))
     ((both-false)
      (raisu 'TODO-3:both-undefined x y)))))
