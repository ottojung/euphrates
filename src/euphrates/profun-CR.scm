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

;; Profun's Custom Results

;; Returned by an agent that wants to overwrite the resulting query.
;; Every other results except this abort's `what' must be ignored.
;; Results are not in the form `(((X . 1) (Y . 2) ...) ...)' but in the form of a query to evaluate that will return that type of the result.

%var make-profun-CR
%var profun-CR?
%var profun-CR-what

%use (make-profun-abort profun-abort-type profun-abort-what profun-abort?) "./profun-abort.scm"

(define (make-profun-CR what)
  (make-profun-abort 'CR what))

(define (profun-CR? x)
  (and (profun-abort? x)
       (equal? 'CR (profun-abort-type x))))

(define (profun-CR-what x)
  (profun-abort-what x))
