;;;; Copyright (C) 2021  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
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

;; a simpler, less-demanding alternative to define-rec
%var define-newtype

%for (COMPILER "guile")

(use-modules (srfi srfi-9))

(define-syntax define-newtype
  (syntax-rules ()
    ((_ constructor predicate get)
     (define-record-type <newtype>
       (constructor constructor)
       predicate
       (constructor get)))
    ((_ constructor predicate get set)
     (define-record-type <newtype>
       (constructor constructor)
       predicate
       (constructor get set)))))

%end

%for (COMPILER "racket")

(define-syntax define-newtype
  (syntax-rules ()
    ((_ constructor predicate get)
     (begin
       (struct <newtype>
               (e)
               #:reflection-name (quote constructor))
       (define constructor <newtype>)
       (define predicate <newtype>?)
       (define get <newtype>-e)
       (define set set-<newtype>-e!)))
    ((_ name constructor predicate get set)
     (begin
       (struct <newtype>
               ([e #:mutable])
               #:reflection-name (quote constructor))
       (define constructor <newtype>)
       (define predicate <newtype>?)
       (define get <newtype>-e)
       (define set set-<newtype>-e!)))))

%end
