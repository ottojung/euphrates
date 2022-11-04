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

;; Used in bottom-handler to return just some predefined values
%var profun-make-set

%use (bool->profun-result) "./bool-to-profun-result.scm"
%use (profun-ctx-set profun-set) "./profun-accept.scm"
%use (profun-op-lambda) "./profun-op-lambda.scm"
%use (profun-reject) "./profun-reject.scm"
%use (profun-bound-value?) "./profun.scm"

(define-syntax profun-make-set
  (syntax-rules ()
    ((_ value)
     (let ((lst #f))
       (profun-op-lambda
        ctx (x)
        (unless lst (set! lst value))
        (if (profun-bound-value? x)
            (bool->profun-result
             (not (not (member x lst))))
            (let ((ctxx (or ctx lst)))
              (if (null? ctxx)
                  (profun-reject)
                  (profun-set
                   ([0] <- (car ctxx))
                   (profun-ctx-set (cdr ctxx)))))))))))
