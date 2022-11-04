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
%use (raisu) "./raisu.scm"

(define (profun-op-binary action left-inverse right-inverse)
  (define (g-op ind x y z op)
    (define (in-op-domain? x)
      (and (integer? x) (>= x 0)))

    (unless (and (in-op-domain? x) (in-op-domain? y))
      (raisu 'TODO-6:non-naturals-in-op x y))

    (let ((result (op x y)))
      (bool->profun-result
       (and result (in-op-domain? result)
            (if z
                (= z result)
                (profun-set ([ind] <- result)))))))

  (profun-op-lambda
   ctx (x y z)
   (cond
    ((and x y) (g-op 2 x y z action))
    ((and x z) (g-op 1 z x y left-inverse))
    ((and y z) (g-op 0 z y x right-inverse))
    (else (raisu 'need-more-info-in-+ x y z)))))

