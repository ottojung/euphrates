;;;; Copyright (C) 2020, 2021, 2022  Otto Jung
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

%var profun-make-handler
%var profun-handler-get
%var profun-handler-extend

%use (hashmap-merge hashmap-ref multi-alist->hashmap) "./hashmap.scm"
%use (list-find-first) "./list-find-first.scm"
%use (profun-op-arity) "./profun-op-obj.scm"
%use (profun-variable-arity-op?) "./profun-variable-arity-op-huh.scm"

(define-syntax profun-make-handler-helper
  (syntax-rules ()
    ((_ buf ())
     (multi-alist->hashmap buf))
    ((_ buf ((name op) . rest))
     (profun-make-handler-helper
      (cons (cons (quote name) op) buf)
      rest))))

(define-syntax profun-make-handler
  (syntax-rules ()
    ((_ . cases)
     (profun-make-handler-helper '() cases))))

(define (profun-handler-get handler key ex-arity)
  (define ret (hashmap-ref handler key '()))
  (list-find-first
   (lambda (handler)
     (or (profun-variable-arity-op? handler)
         (= (profun-op-arity handler)
            ex-arity)))
   #f
   ret))

(define-syntax profun-handler-extend
  (syntax-rules ()
    ((_ handler . cases)
     (let ((additional (profun-make-handler . cases)))
       (hashmap-merge handler additional)))))
