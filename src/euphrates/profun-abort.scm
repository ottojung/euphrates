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





(define-type9 <profun-abort>
  (profun-abort-constructor type iter what additional) profun-abort-obj?
  (type profun-abort-type)
  (iter profun-abort-iter)
  (what profun-abort-what)
  (additional profun-abort-additional)
  )

(define (profun-abort? x)
  (profun-abort-obj? x))

(define (make-profun-abort type what)
  (define additional '())
  (define iter #f)
  (profun-abort-constructor type iter what additional))

(define (profun-abort-set-iter self iter)
  (define type (profun-abort-type self))
  (define what (profun-abort-what self))
  (define additional (profun-abort-additional self))
  (profun-abort-constructor type iter what additional))

(define (profun-abort-modify-iter self modification)
  (define type (profun-abort-type self))
  (define what (profun-abort-what self))
  (define additional (profun-abort-additional self))
  (define iter
    (lambda args
      (modification (apply args iter))))
  (profun-abort-constructor type iter what additional))

(define (profun-abort-add-info self additional-rules)
  (define type (profun-abort-type self))
  (define what (profun-abort-what self))
  (define iter (profun-abort-iter self))
  (define additional (profun-abort-additional self))
  (define new-additional (append additional additional-rules))
  (profun-abort-constructor type iter what new-additional))
