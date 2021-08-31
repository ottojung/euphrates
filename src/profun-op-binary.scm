;;;; Copyright (C) 2020, 2021  Otto Jung
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

%use (profun-handler-lambda) "./profun-handler-lambda.scm"
%use (raisu) "./raisu.scm"

(define (profun-op-binary action left-inverse right-inverse)
  (define (g-op ind x y z op)
    (define (in-op-domain? x)
      (and (integer? x) (>= x 0)))
    (define (repack ind z)
      (case ind
        ((0) (list z #t #t))
        ((1) (list #t z #t))
        ((2) (list #t #t z))))

    (unless (and (in-op-domain? x) (in-op-domain? y))
      (raisu 'TODO-6:non-naturals-in-op x y))
    (let ((result (op x y)))
      (and result (in-op-domain? result)
           (if z
               (= z result)
               (cons (repack ind result) #f)))))

  (profun-handler-lambda
   3 (args ctx)
   (define x (car args))
   (define y (cadr args))
   (define z (car (cdr (cdr args))))

   (cond
    ((and x y) (g-op 2 x y z action))
    ((and x z) (g-op 1 z x y left-inverse))
    ((and y z) (g-op 0 z y x right-inverse))
    (else (raisu 'need-more-info-in-+ args)))))

