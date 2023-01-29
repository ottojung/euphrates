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

(cond-expand
 (guile
  (define-module (euphrates profun-make-instantiation-test)
    :export (profun-make-instantiation-check)
    :use-module ((euphrates profun-query-get-free-variables) :select (profun-query-get-free-variables))
    :use-module ((euphrates list-and-map) :select (list-and-map)))))



;; takes result alist and returns #t or #f
(define (profun-make-instantiation-check query)
  (let ((free (profun-query-get-free-variables query)))
    (lambda (result)
      (list-and-map
       (lambda (var) (assq var result))
       free))))
