;;;; Copyright (C) 2022  Otto Jung
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
  (define-module (euphrates profun-op-unary)
    :export (profun-op-unary)
    :use-module ((euphrates bool-to-profun-result) :select (bool->profun-result))
    :use-module ((euphrates profun-accept) :select (profun-set))
    :use-module ((euphrates profun-op-lambda) :select (profun-op-lambda))
    :use-module ((euphrates profun-request-value) :select (profun-request-value))
    :use-module ((euphrates profun-value) :select (profun-bound-value?)))))



(define (profun-op-unary action inverse)
  (define (in-op-domain? u)
    (and (integer? u) (>= u 0)))

  (define (g-op name x y op)
    (bool->profun-result
     (and (in-op-domain? x)
          (let ((result (op x)))
            (and result
                 (in-op-domain? result)
                 (if (profun-bound-value? y)
                     (= y result)
                     (profun-set (name <- result))))))))

  (profun-op-lambda
   (ctx (x y) (x-name y-name))
   (cond
    ((profun-bound-value? x)
     (g-op y-name x y action))
    ((profun-bound-value? y)
     (g-op x-name y x inverse))
    (else
     (profun-request-value `(any ,x-name ,y-name))))))
