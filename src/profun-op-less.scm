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

%use (profun-handler-lambda) "./profun-handler-lambda.scm"
%use (raisu) "./raisu.scm"

(define profun-op-less
  (profun-handler-lambda
   2 (args ctx)
   (define xv (car args))
   (define yv (cadr args))

   (unless (number? yv)
     (raisu 'non-number-in-less args))

   (if xv
       (if (number? xv)
           (and (not ctx) (< xv yv) #t)
           (raisu 'non-number-in-less args))
       (if (< yv 1) #f
           (let* ((ctxx (or ctx yv))
                  (ctxm (- ctxx 1)))
             (and (>= ctxm 0)
                  (cons (list ctxm #t) ctxm)))))))
