;;;; Copyright (C) 2021, 2022, 2023  Otto Jung
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


;; In order to return result during apply evaluation, call `profun-apply-return!';
;; in order to fail, call `profun-apply-fail!'.


(define profun-op-apply
  (profun-op-lambda
   (ctx args names)
   (if (or ctx (null? args)) (profun-reject)
       (let ((procedure (car args))
             (arguments (cdr args))
             (box (make-box #f)))

         (parameterize ((profun-op-apply/result/p box))
           (apply procedure arguments))

         (let ((result (box-ref box))
               (len (length arguments)))
           (case result
             ((fail) (profun-reject))
             ((#f) (profun-ctx-set #t))
             (else
              (let loop ((i 1) (rest result) (arguments arguments))
                (if (<= i len)
                    (if (profun-bound-value? (car arguments))
                        (if (equal? (car arguments)
                                    (car rest))
                            (loop (+ 1 i) (cdr rest) (cdr arguments))
                            (profun-reject))
                        (profun-set
                         ((list-ref names i) <- (car rest))
                         (loop (+ 1 i) (cdr rest) (cdr arguments))))
                    (profun-ctx-set #t))))))))))

(define (profun-apply-return! . args)
  (let ((box (profun-op-apply/result/p)))
    (unless (box? box)
      (raisu 'profun-apply-return-called-outside-of-apply box))
    (box-set! box args)))

(define (profun-apply-fail!)
  (let ((box (profun-op-apply/result/p)))
    (unless (box? box)
      (raisu 'profun-apply-return-called-outside-of-apply box))
    (box-set! box 'fail)))
