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

(cond-expand
 (guile
  (define-module (euphrates petri-error-handling)
    :export (patri-handle-make-callback petri-handle-get))))


(define (patri-handle-make-callback error-handler)
  (lambda (alist)
    (define interface (petri-handle-make-interface alist))
    (define type (petri-handle-get 'type interface))
    (define args (petri-handle-get 'args interface))
    (error-handler type interface)))

(define (petri-handle-make-interface alist)
  alist)

(define (petri-handle-get name interface)
  (define var (assoc name interface))
  (and var (cadr var)))
