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

(define-syntax profun-make-handler-helper
  (syntax-rules ()
    ((_ key ex-arity buf ())
     (case key . buf))
    ((_ key ex-arity buf ((name op) . rest))
     (profun-make-handler-helper
      key ex-arity
      (((name) (if (pair? op) (and (= (car op) ex-arity) (cdr op)) op)) . buf)
      rest))))

(define-syntax profun-make-handler
  (syntax-rules ()
    ((_ . cases)
     (lambda (key ex-arity)
       (profun-make-handler-helper key ex-arity ((else #f)) cases)))))
