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

%var profun-op-less

%use (bool->profun-result) "./bool-to-profun-result.scm"
%use (profun-ctx-set profun-set) "./profun-accept.scm"
%use (profun-op-lambda) "./profun-op-lambda.scm"
%use (profun-reject) "./profun-reject.scm"
%use (profun-bound-value?) "./profun.scm"
%use (raisu) "./raisu.scm"

(define profun-op-less
  (profun-op-lambda
   ctx (xv yv)

   (unless (number? yv)
     (raisu 'non-number-in-less yv))

   (bool->profun-result
    (if (profun-bound-value? xv)
        (if (number? xv)
            (and (not ctx) (< xv yv))
            (raisu 'non-number-in-less xv))
        (if (< yv 1) (profun-reject)
            (let* ((ctxx (or ctx yv))
                   (ctxm (- ctxx 1)))
              (and (>= ctxm 0)
                   (profun-set
                    ([0] <- ctxm)
                    (profun-ctx-set ctxm)))))))))
