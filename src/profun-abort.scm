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

%var make-profun-abort
%var profun-abort?
%var profun-abort-type
%var profun-abort-what
%var profun-abort-set-continuation
%var profun-abort-modify-continuation

%var profun-abort-add-info
%var profun-abort-insert
%var profun-abort-reset

%use (comp) "./comp.scm"
%use (define-type9) "./define-type9.scm"
%use (profun-database-add-rule!) "./profun-database.scm"
%use (profun-iterator-copy profun-iterator-db profun-iterator-insert! profun-iterator-reset!) "./profun-iterator.scm"

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

(define (profun-abort-modify-continuation self modification)
  (define type (profun-abort-type self))
  (define what (profun-abort-what self))
  (define additional (profun-abort-additional self))
  (define continuation
    (lambda args
      (modification (apply args continuation))))
  (profun-abort-constructor type continuation what additional))

(define (profun-abort-add-info self additional-rules)
  (define type (profun-abort-type self))
  (define what (profun-abort-what self))
  (define continuation (profun-abort-continuation self))
  (define additional (profun-abort-additional self))
  (define new-additional (append additional additional-rules))
  (profun-abort-constructor type continuation what new-additional))

(define (profun-abort-insert self inserted)
  "Inserts `inserted' just before the instruction that throwed this abort, and continues evaluation."

  (define iter (profun-abort-continuation self))
  (define new-iter (profun-iterator-copy iter))
  (define new-db (profun-iterator-db new-iter))
  (define additional (profun-abort-additional self))
  (for-each (comp (profun-database-add-rule! new-db)) additional)
  (profun-iterator-insert! new-iter inserted)
  new-iter)

(define (profun-abort-reset self new-query)
  "Evaluates `new-query' starting from state before the abort was thrown. Any later computation is ignored."

  (define iter (profun-abort-continuation self))
  (define new-iter (profun-iterator-copy iter))
  (define new-db (profun-iterator-db new-iter))
  (define additional (profun-abort-additional self))
  (for-each (comp (profun-database-add-rule! new-db)) additional)
  (profun-iterator-reset! new-iter new-query)
  new-iter)
