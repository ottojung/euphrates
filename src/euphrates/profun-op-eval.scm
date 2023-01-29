;;;; Copyright (C) 2021, 2022  Otto Jung
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

(cond-expand
 (guile
  (define-module (euphrates profun-op-eval)
    :export (profun-op-eval profun-eval-return! profun-eval-fail!)
    :use-module ((euphrates box) :select (box-ref box-set! box? make-box))
    :use-module ((euphrates profun-accept) :select (profun-ctx-set profun-set))
    :use-module ((euphrates profun-op-eval-result-p) :select (profun-op-eval/result#p))
    :use-module ((euphrates profun-op-lambda) :select (profun-op-lambda))
    :use-module ((euphrates profun-reject) :select (profun-reject))
    :use-module ((euphrates raisu) :select (raisu)))))

;; In order to return result during apply evaluation, call `profun-apply-return!';
;; in order to fail, call `profun-apply-fail!'.


(define profun-op-eval
  (profun-op-lambda
   (ctx args names)
   (if (or ctx
           (null? args)
           (null? (cdr args)))
       (profun-reject)
       (let ((destination (car args))
             (procedure (cadr args))
             (arguments (cddr args))
             (box (make-box #f)))

         (parameterize ((profun-op-eval/result#p box))
           (let ((result (apply procedure arguments)))
             (if (equal? 'fail (box-ref box))
                 (profun-reject)
                 (profun-set
                  ((car names) <- result)
                  (profun-ctx-set #t)))))))))

(define (profun-eval-fail!)
  (let ((box (profun-op-eval/result#p)))
    (unless (box? box)
      (raisu 'profun-eval-return-called-outside-of-eval box))
    (box-set! box 'fail)))
