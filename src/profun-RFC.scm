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

%var make-profun-RFC
%var profun-RFC?
%var profun-RFC-what
%var profun-RFC-set-continuation
%var profun-RFC-modify-continuation

%var profun-RFC-add-info
%var profun-RFC-insert
%var profun-RFC-reset

%use (make-profun-abort profun-abort-add-info profun-abort-insert profun-abort-reset profun-abort-modify-continuation profun-abort-set-continuation profun-abort-type profun-abort-what profun-abort?) "./profun-abort.scm"

(define (make-profun-RFC what)
  (make-profun-abort 'RFC what))

(define (profun-RFC? x)
  (and (profun-abort? x)
       (equal? 'RFC (profun-abort-type x))))

(define profun-RFC-what profun-abort-what)
(define profun-RFC-set-continuation profun-abort-set-continuation)
(define profun-RFC-modify-continuation profun-abort-modify-continuation)

(define profun-RFC-add-info profun-abort-add-info)
(define profun-RFC-insert profun-abort-insert)
(define profun-RFC-reset profun-abort-reset)
