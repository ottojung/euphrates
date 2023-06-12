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


;; Profun's I Don't Recognize

;; Returned by an agent that does not know what to do with a symbol.
;; For example, if agent does not know how to do addition, he will return IDR encountering symbol `+'.



(define (make-profun-IDR key arity)
  (make-profun-abort 'IDR (list key arity)))

(define (profun-IDR? x)
  (and (profun-abort? x)
       (equal? 'IDR (profun-abort-type x))))

(define (profun-IDR-name x)
  (car (profun-abort-what x)))

(define (profun-IDR-arity x)
  (cadr (profun-abort-what x)))
