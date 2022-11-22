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

;; Profun's I Don't Recognize

;; Returned by an agent that does not know what to do with a symbol.
;; For example, if agent does not know how to do addition, he will return IDR encountering symbol `+'.

%var make-profun-IDR
%var profun-IDR?
%var profun-IDR-name
%var profun-IDR-arity

%use (define-type9) "./define-type9.scm"

(define-type9 profun-IDR-obj
  (profun-IDR-constructor name arity) profun-IDR-obj?
  (name profun-IDR-name)
  (arity profun-IDR-arity)
  )

(define (profun-IDR? x)
  (profun-IDR-obj? x))

(define (make-profun-IDR name arity)
  (profun-IDR-constructor name arity))
