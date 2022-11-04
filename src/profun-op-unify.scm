;;;; Copyright (C) 2020, 2021, 2022  Otto Jung
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

%use (profun-accept profun-set) "./profun-accept.scm"
%use (profun-op-lambda) "./profun-op-lambda.scm"
%use (profun-reject) "./profun-reject.scm"
%use (profun-variable-equal?) "./profun-variable-equal-q.scm"
%use (raisu) "./raisu.scm"

(define profun-op-unify
  (profun-op-lambda
   ctx (x y)
   (case (profun-variable-equal? x y)
     ((#t) (profun-accept))
     ((#f) (profun-reject))
     ((x-false) (profun-set ([0] <- y)))
     ((y-false) (profun-set ([1] <- x)))
     ((both-false)
      (raisu 'TODO-3:both-undefined x y)))))
