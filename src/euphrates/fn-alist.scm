;;;; Copyright (C) 2023  Otto Jung
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
  (define-module (euphrates fn-alist)
    :export (fn-alist)
    :use-module ((euphrates assq-or) :select (assq-or))
    :use-module ((euphrates raisu) :select (raisu)))))



(define-syntax fn-alist
  (syntax-rules ()
    ;; TODO: support default arguments
    ((_ (name . names) . bodies)
     (let ((q (quote (name . names))))
       (lambda (alist)
         (define args
           (map
            (lambda (key)
              (assq-or key alist (raisu 'argument-not-found-in-alist key)))
            q))
         (apply (lambda (name . names) . bodies) args))))))
