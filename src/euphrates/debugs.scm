;;;; Copyright (C) 2022, 2021, 2023  Otto Jung
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


;; pretty-prints a serialized version an object


(define-syntax debugs
  (syntax-rules ()
    ((_ x)
     (let* ((y x)
            (sy (serialize/short y)))
       (if (pair? sy)
           (debug "~a:\n~a" (quote x)
                  (with-output-stringified
                    (pretty-print sy)))
           (debug "~a = ~s" (quote x) sy))
       y))))
