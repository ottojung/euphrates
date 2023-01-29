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
  (define-module (euphrates system-environment)
    :export (system-environment-get system-environment-set!))))


(cond-expand
 (guile

  (define (system-environment-get s)
    (getenv s))

  (define (system-environment-set! s v)
    (setenv s v))

  ))
(cond-expand
 (racket

  (define (system-environment-get s)
    (getenv s))

  (define (system-environment-set! s v)
    (if v
    (putenv s v) ;; Guile's procedure is called `setenv', except that it accepts #f
    (environment-variables-set!
     (current-environment-variables)
     (string->bytes/locale s (char->integer #\?))
     #f)))

  ))
