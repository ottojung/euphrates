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

%run guile

%var profun-op-binary

%use (bool->profun-result) "./bool-to-profun-result.scm"
%use (make-profun-RFC) "./profun-RFC.scm"
%use (profun-set) "./profun-accept.scm"
%use (profun-op-lambda) "./profun-op-lambda.scm"
%use (profun-bound-value?) "./profun-value.scm"

(define (profun-op-binary action left-inverse right-inverse)
  (define (in-op-domain? x)
    (and (integer? x) (>= x 0)))

  (define (g-op name x y z op)
    (bool->profun-result
     (and (in-op-domain? x)
          (in-op-domain? y)
          (let ((result (op x y)))
            (and result
                 (in-op-domain? result)
                 (if (profun-bound-value? z)
                     (= z result)
                     (profun-set (name <- result))))))))

  (profun-op-lambda
   (ctx (x y z) (x-name y-name z-name))
   (cond
    ((and (profun-bound-value? x)
          (profun-bound-value? y))
     (g-op z-name x y z action))
    ((and (profun-bound-value? x)
          (profun-bound-value? z))
     (g-op y-name z x y left-inverse))
    ((and (profun-bound-value? y)
          (profun-bound-value? z))
     (g-op x-name z y x right-inverse))
    ((profun-bound-value? x)
     (make-profun-RFC `((what ,y-name ,z-name))))
    ((profun-bound-value? y)
     (make-profun-RFC `((what ,x-name ,z-name))))
    ((profun-bound-value? z)
     (make-profun-RFC `((what ,x-name ,y-name))))
    (else
     (make-profun-RFC `((what ,x-name ,y-name ,z-name)))))))
