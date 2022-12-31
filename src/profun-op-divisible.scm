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

%var profun-op-divisible

%use (bool->profun-result) "./bool-to-profun-result.scm"
%use (profun-ctx-set profun-set) "./profun-accept.scm"
%use (profun-op-lambda) "./profun-op-lambda.scm"
%use (make-profun-RFC) "./profun-RFC.scm"
%use (profun-bound-value? profun-unbound-value?) "./profun-value.scm"
%use (raisu) "./raisu.scm"

(define profun-op-divisible
  (profun-op-lambda
   (ctx (y x) (x-name y-name))
   (define last (or ctx 1))

   (if (profun-unbound-value? y)
       (make-profun-RFC y-name)
       (and
        (or (number? y)
            (raisu 'non-number-in-divisible y-name y))
        (bool->profun-result
         (if (profun-bound-value? x)
             (and (or (number? x)
                      (raisu 'non-number-in-divisible x-name x))
                  (not (= 0 x))
                  (= 0 (remainder y x)))
             (and (< last y)
                  (let loop ((i last) (cnt 0))
                    (if (= 0 (remainder y i))
                        (profun-set
                         (y-name <- i)
                         (profun-ctx-set (+ 1 i)))
                        (loop (+ 1 i) cnt))))))))))
