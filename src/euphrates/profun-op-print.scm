;;;; Copyright (C) 2021, 2022  Otto Jung
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
  (define-module (euphrates profun-op-print)
    :export (profun-op-print)
    :use-module ((euphrates bool-to-profun-result) :select (bool->profun-result))
    :use-module ((euphrates dprintln) :select (dprintln))
    :use-module ((euphrates profun-op-lambda) :select (profun-op-lambda)))))



(define profun-op-print
  (profun-op-lambda
   (ctx args names)
   (bool->profun-result
    (and (not ctx)
         (not (null? args))
         (begin
           (apply dprintln args)
           #t)))))
