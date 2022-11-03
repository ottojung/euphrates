;;;; Copyright (C) 2020, 2021  Otto Jung
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

%use (debugs) "./debugs.scm"
%use (hashmap-ref multi-alist->hashmap) "./ihashmap.scm"
%use (list-find-first) "./list-find-first.scm"
%use (profun-handler-arity) "./profun-handler-obj.scm"
%use (profun-variable-arity-handler?) "./profun-variable-arity-handler-huh.scm"

(define-syntax profun-make-handler-helper
  (syntax-rules ()
    ((_ kkk zzzz buf ())
     (let ((H (multi-alist->hashmap buf)))
       (lambda (key ex-arity)
         ;; (debugs `(get ,key ,ex-arity))
         (let ((ret (hashmap-ref H key '())))
           (list-find-first
            (lambda (handler)
              (or (profun-variable-arity-handler? handler)
                  (= (profun-handler-arity handler)
                     ex-arity)))
            #f
            ret)))))

    ((_ key ex-arity buf ((name op) . rest))
     (profun-make-handler-helper
      key ex-arity
      (cons (cons (quote name) op) buf)
      rest))))

(define-syntax profun-make-handler
  (syntax-rules ()
    ((_ . cases)
     (profun-make-handler-helper 0 0 '() cases))))
