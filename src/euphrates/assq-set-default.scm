;;;; Copyright (C) 2023  Otto Jung
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
  (define-module (euphrates assq-set-default)
    :export (assq-set-default)
    :use-module ((euphrates assq-set-value) :select (assq-set-value)))))



(define-syntax assq-set-default
  (syntax-rules ()
    ((_ key/0 value alist/0)
     (let ()
       (define key key/0)
       (define alist alist/0)
       (define got (assq key alist))
       (if got alist (assq-set-value key value alist))))))
