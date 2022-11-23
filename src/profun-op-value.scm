;;;; Copyright (C) 2022  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
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

%var profun-op-value

%use (profun-set) "./profun-accept.scm"
%use (profun-answer-join/and profun-answer-join/any profun-answer-join/or) "./profun-answer-join.scm"
%use (profun-op-lambda) "./profun-op-lambda.scm"
%use (profun-reject) "./profun-reject.scm"
%use (raisu) "./raisu.scm"

(define (profun-op-value custom-its custom-alist value-alist)
  (profun-op-lambda
   (ctx (x) (x-name))
   (let loop ((x x))
     (cond
      ((symbol? x)
       (let ((val/p (assq x value-alist)))
         (if val/p
             (profun-set (x <- (cdr val/p)))
             (let ((val/p (assq x custom-alist)))
               (if val/p
                   (profun-set (custom-its <- (cdr val/p)))
                   (profun-reject))))))
      ((and (pair? x)
            (list? (cdr x)))
       (let ((composer
              (case (car x)
                ((any) profun-answer-join/any)
                ((or) profun-answer-join/or)
                ((and) profun-answer-join/and)
                (else (raisu 'uknown-value-composer (car x))))))
         (let lp2 ((buf (cdr x))
                   (ret (profun-reject)))
           (if (null? buf) ret
               (let* ((u (car buf))
                      (y (loop u)))
                 (lp2 (cdr buf) (composer ret y)))))))
      (else
       (raisu 'uknown-value-format x))))))
