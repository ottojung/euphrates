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

%var profun-RFC-add-info
%var profun-RFC-continue-with-inserted
%var profun-RFC-eval-inserted

%use (define-type9) "./define-type9.scm"

(define-type9 profun-RFC-obj
  (profun-RFC-constructor continuation what additional) profun-RFC-obj?
  (continuation profun-RFC-continuation)
  (what profun-RFC-what)
  (additional profun-RFC-additional)
  )

(define (profun-RFC? x)
  (profun-RFC-obj? x))

(define (make-profun-RFC what)
  (define additional '())
  (define continuation #f)
  (profun-RFC-constructor continuation what additional))

(define (profun-RFC-set-continuation self continuation)
  (define what (profun-RFC-what self))
  (define additional (profun-RFC-additional self))
  (profun-RFC-constructor continuation what additional))

(define (profun-RFC-add-info self additional-rules)
  (define what (profun-RFC-what self))
  (define continuation (profun-RFC-continuation self))
  (define additional (profun-RFC-additional self))
  (define new-additional (append additional additional-rules))
  (profun-RFC-constructor continuation what new-additional))

(define (profun-RFC-continue-with-inserted self inserted)
  "Inserts `inserted' just before the instruction that throwed this RFC, and continues evaluation."

  (define continuation (profun-RFC-continuation self))
  (define additional (profun-RFC-additional self))
  (define continue? #t)
  (continuation continue? additional inserted))

(define (profun-RFC-eval-inserted self inserted)
  "Evaluates `inserted' starting from state before the RFC was thrown. Any later computation is ignored."

  (define continuation (profun-RFC-continuation self))
  (define additional (profun-RFC-additional self))
  (define continue? #f)
  (continuation continue? additional inserted))
