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

%var profun-op-separate

%use (profun-accept) "./profun-accept.scm"
%use (profun-op-lambda) "./profun-op-lambda.scm"
%use (profun-reject) "./profun-reject.scm"
%use (profun-variable-equal?) "./profun-variable-equal-q.scm"
%use (raisu) "./raisu.scm"

(define profun-op-separate
  (profun-op-lambda
   ctx (x y)
   (case (profun-variable-equal? x y)
     ((#t) (profun-reject))
     ((#f) (profun-accept))
     ((x-false) (profun-reject)) ;; FIXME: ask what is x, y.
     ((y-false) (profun-reject)) ;; FIXME: ask what is x, y.
     ((both-false)
      (raisu 'TODO-4:both-undefined-in-separate x y)))))
