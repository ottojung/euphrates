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
  (define-module (euphrates list-ref-or)
    :export (list-ref-or))))


(define-syntax list-ref-or
  (syntax-rules ()
    ((_ lst-0 ref-0 default)
     (let lp ((lst lst-0) (ref ref-0))
       (if (null? lst) default
           (if (= 0 ref)
               (car lst)
               (lp (cdr lst) (- ref 1))))))))
