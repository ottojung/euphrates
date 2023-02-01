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
  (define-module (euphrates run-syncproc-re)
    :export (run-syncproc/re)
    :use-module ((euphrates asyncproc) :select (asyncproc-status))
    :use-module ((euphrates raisu) :select (raisu))
    :use-module ((euphrates run-syncproc) :select (run-syncproc))
    )))

(define (run-syncproc/re command . args)
  (with-output-to-string
    (lambda _
      (define p
        (apply run-syncproc (cons command args)))
      (unless (= 0 (asyncproc-status p))
        (raisu 'child-process-failed
               (cons command args)
               (asyncproc-status p))))))
