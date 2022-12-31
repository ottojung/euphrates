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
%use (profun-set) "./profun-accept.scm"
%use (profun-op-lambda) "./profun-op-lambda.scm"
%use (profun-request-value) "./profun-request-value.scm"
%use (profun-bound-value?) "./profun-value.scm"

(define (profun-op-binary action left-inverse right-inverse both-inverse left-identity right-identity)
  (define (in-op-domain? x)
    (and (integer? x) (>= x 0)))

  (profun-op-lambda
   (ctx (x y z) (x-name y-name z-name))

   (define (g-op c-name a b c op)
     (bool->profun-result
      (and (in-op-domain? a)
           (in-op-domain? b)
           (let ((result (op a b)))
             (if (equal? result 'op-binary-rfc)
                 (profun-request-value c-name)
                 (and result
                      (in-op-domain? result)
                      (if (profun-bound-value? c)
                          (= c result)
                          (profun-set (c-name <- result)))))))))

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
     (if (equal? y z)
         (g-op z-name x x z left-identity)
         (profun-request-value `(any ,y-name ,z-name))))
    ((profun-bound-value? y)
     (if (equal? x z)
         (g-op x-name y y z right-identity)
         (profun-request-value `(any ,x-name ,z-name))))
    ((profun-bound-value? z)
     (if (equal? x y)
         (g-op x-name z z x both-inverse)
         (profun-request-value `(any ,x-name ,y-name))))
    (else
     (profun-request-value `(any ,x-name ,y-name ,z-name))))))
