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

%var profun-op-separate

%use (make-profun-RFC) "./profun-RFC.scm"
%use (profun-accept) "./profun-accept.scm"
%use (profun-op-lambda) "./profun-op-lambda.scm"
%use (profun-reject) "./profun-reject.scm"
%use (profun-variable-equal?) "./profun-variable-equal-q.scm"

(define profun-op-separate
  (profun-op-lambda
   (ctx (x y) (x-name y-name))
   (case (profun-variable-equal? x y)
     ((#t) (profun-reject))
     ((#f) (profun-accept))
     ((x-false) (make-profun-RFC #f `((what ,x-name))))
     ((y-false) (make-profun-RFC #f `((what ,y-name))))
     ((both-false) (make-profun-RFC #f `((what ,x-name ,y-name)))))))
