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

%var list-map-first

%use (raisu) "./raisu.scm"

(define-syntax list-map-first
  (syntax-rules ()
    ((_ f lst)
     (let ((ff f))
       (list-map-first ff
                       (raisu 'no-first-element-to-satisfy-predicate ff)
                       lst)))
    ((_ f0 default lst0)
     (let ((f f0))
       (let loop ((lst lst0))
         (if (null? lst) default
             (let ((x (car lst)))
               (or (f x)
                   (loop (cdr lst))))))))))
