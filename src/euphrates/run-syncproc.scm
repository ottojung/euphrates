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
  (define-module (euphrates run-syncproc)
    :export (run-syncproc)
    :use-module ((euphrates run-asyncproc) :select (run-asyncproc))
    :use-module ((euphrates with-singlethread-env) :select (with-singlethread-env))
    )))

(define (run-syncproc command . args)
  (with-singlethread-env
   (apply run-asyncproc (cons command args))))
