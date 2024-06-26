;;;; Copyright (C) 2020, 2021, 2022, 2023  Otto Jung
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


;; Used in bottom-handler to return just some predefined values


(define-syntax profun-make-set
  (syntax-rules ()
    ((_ value)
     (let ((lst #f))
       (profun-op-lambda
        (ctx (x) (x-name))
        (unless lst (set! lst value))
        (if (profun-bound-value? x)
            (bool->profun-result
             (not (not (member x lst))))
            (let ((ctxx (or ctx lst)))
              (if (null? ctxx)
                  (profun-reject)
                  (profun-set
                   (x-name <- (car ctxx))
                   (profun-ctx-set (cdr ctxx)))))))))))
