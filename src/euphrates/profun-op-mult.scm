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

%var profun-op*

%use (profun-op-binary) "./profun-op-binary.scm"

(define profun-op*
  (let ((safe-div
         (lambda (a b)
           (and (not (= 0 b)) (/ a b))))
        (safe-sqrt
         (lambda (x z)
           (let ((z (sqrt x)))
             (and (integer? z) (inexact->exact z)))))
        (l/r-identity
         (lambda (x z)
           (case x
            ((0) 0)
            ((1) 'op-binary-rfc)
            (else #f)))))

    (profun-op-binary * safe-div safe-div safe-sqrt l/r-identity l/r-identity)))
