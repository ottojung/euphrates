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
;; For example, if agent receives query `(+ 1 x y)', he may return an abort for argument `x' to avoid returning infinitely many results.

%var make-profun-abort
%var profun-abort?
%var profun-abort-type
%var profun-abort-what
%var profun-abort-set-continuation

%var profun-abort-add-info
%var profun-abort-continue-with-inserted
%var profun-abort-eval-inserted

%use (define-type9) "./define-type9.scm"

(define-type9 <profun-abort>
  (profun-abort-constructor type continuation what additional) profun-abort-obj?
  (type profun-abort-type)
  (continuation profun-abort-continuation)
  (what profun-abort-what)
  (additional profun-abort-additional)
  )

(define (profun-abort? x)
  (profun-abort-obj? x))

(define (make-profun-abort type what)
  (define additional '())
  (define continuation #f)
  (profun-abort-constructor type continuation what additional))

(define (profun-abort-set-continuation self continuation)
  (define type (profun-abort-type self))
  (define what (profun-abort-what self))
  (define additional (profun-abort-additional self))
  (profun-abort-constructor type continuation what additional))

(define (profun-abort-add-info self additional-rules)
  (define type (profun-abort-type self))
  (define what (profun-abort-what self))
  (define continuation (profun-abort-continuation self))
  (define additional (profun-abort-additional self))
  (define new-additional (append additional additional-rules))
  (profun-abort-constructor type continuation what new-additional))

(define (profun-abort-continue-with-inserted self inserted)
  "Inserts `inserted' just before the instruction that throwed this abort, and continues evaluation."

  (define continuation (profun-abort-continuation self))
  (define additional (profun-abort-additional self))
  (define continue? #t)
  (continuation continue? additional inserted))

(define (profun-abort-eval-inserted self inserted)
  "Evaluates `inserted' starting from state before the abort was thrown. Any later computation is ignored."

  (define continuation (profun-abort-continuation self))
  (define additional (profun-abort-additional self))
  (define continue? #f)
  (continuation continue? additional inserted))
