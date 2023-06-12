;;;; Copyright (C) 2020, 2021, 2022  Otto Jung
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




(define profun-op-less
  (profun-op-lambda
   (ctx (x y) (x-name y-name))

   (if (profun-unbound-value? y)
       (profun-request-value y-name)
       (begin
         (unless (number? y)
           (raisu 'non-number-in-less y))
         (bool->profun-result
          (if (profun-bound-value? x)
              (if (number? x)
                  (and (not ctx) (< x y))
                  (raisu 'non-number-in-less x))
              (if (< y 1) (profun-reject)
                  (let* ((ctxx (or ctx y))
                         (ctxm (- ctxx 1)))
                    (and (>= ctxm 0)
                         (profun-set
                          (x-name <- ctxm)
                          (profun-ctx-set ctxm)))))))))))
