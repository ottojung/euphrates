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

(cond-expand
 (guile
  (define-module (euphrates profun-op-value)
    :export (profun-op-value)
    :use-module ((euphrates profun-CR) :select (make-profun-CR))
    :use-module ((euphrates profun-accept) :select (profun-accept profun-set))
    :use-module ((euphrates profun-answer-join) :select (profun-answer-join/and profun-answer-join/any profun-answer-join/or))
    :use-module ((euphrates profun-op-envlambda) :select (profun-op-envlambda))
    :use-module ((euphrates profun-reject) :select (profun-reject))
    :use-module ((euphrates profun-value) :select (profun-bound-value? profun-unbound-value? profun-value-name))
    :use-module ((euphrates raisu) :select (raisu)))))



(define (profun-op-value custom-alist value-alist)
  (profun-op-envlambda
   (ctx env (x-name))
   (define x (env x-name))
   (let loop ((x x))
     (cond
      ((symbol? x)
       (let ((val (env x)))
         (if (profun-bound-value? val)
             (profun-accept)
             (let ((val/p (assq x value-alist)))
               (if val/p
                   (profun-set (x <- (cdr val/p)))
                   (let ((val/p (assq x custom-alist)))
                     (if val/p
                         (make-profun-CR (cdr val/p))
                         (profun-reject))))))))
      ((and (pair? x)
            (list? (cdr x)))
       (let* ((op (car x))
              (composer
               (case op
                 ((any) profun-answer-join/any)
                 ((or) profun-answer-join/or)
                 ((and) profun-answer-join/and)
                 (else (raisu 'uknown-value-composer op)))))
         (let lp2 ((buf (cdr x))
                   (ret (case op ((and) (profun-accept)) ((or any) (profun-reject)))))
           (if (null? buf) ret
               (let* ((u (car buf))
                      (y (loop u)))
                 (lp2 (cdr buf) (composer ret y)))))))
      ((profun-unbound-value? x)
       (loop (profun-value-name x)))
      (else
       (profun-accept))))))
