;;;; Copyright (C) 2022  Otto Jung
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

%var monad-bind

%use (monad-do) "./monad-do.scm"

(define-syntax monad-bind
  (syntax-rules ()
    ((_ (x . xs) val . tags)
     (begin
       (define-values (x . xs) (monad-do ((x . xs) val (list . tags))))
       (values x . xs)))
    ((_ var val . tags)
     (begin
       (define var (monad-do (var val (list . tags))))
       var))))
