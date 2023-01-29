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

(cond-expand
 (guile
  (define-module (euphrates profun-handler)
    :export (profun-make-handler profun-handler-get profun-handler-extend)
    :use-module ((euphrates hashmap) :select (hashmap-merge hashmap-ref multi-alist->hashmap))
    :use-module ((euphrates list-find-first) :select (list-find-first))
    :use-module ((euphrates profun-op-obj) :select (profun-op-arity))
    :use-module ((euphrates profun-variable-arity-op-huh) :select (profun-variable-arity-op?)))))



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
