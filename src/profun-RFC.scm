;;;; Copyright (C) 2022  Otto Jung
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

;; Profun's Request For Clarification

;; Returned by an agent that needs more info on one of its arguments in order to complete computation.
;; For example, if agent receives query `(+ 1 x y)', he may return an RFC for argument `x' to avoid returning infinitely many results.

%var profun-RFC
%var profun-RFC?
%var profun-RFC-what
%var profun-RFC-continuation

%use (define-type9) "./define-type9.scm"

(define-type9 profun-RFC-obj
  (profun-RFC-constructor continuation what) profun-RFC-obj?
  (continuation profun-RFC-continuation)
  (what profun-RFC-what)
  )

(define (profun-RFC? x)
  (profun-RFC-obj? x))

(define (profun-RFC continuation what)
  (profun-RFC-constructor continuation what))
