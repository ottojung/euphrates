;;;; Copyright (C) 2021  Otto Jung
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

;; In order to return result during apply evaluation, call `profun-apply-return!';
;; in order to fail, call `profun-apply-fail!'.
%var profun-op-apply
%var profun-apply-return!
%var profun-apply-fail!

%use (profun-op-apply/result#p) "./profun-op-apply-result-p.scm"
%use (make-box box? box-ref box-set!) "./box.scm"

(define profun-op-apply
  (lambda (args ctx)
    (and (not ctx)
         (let ((procedure (car args))
               (arguments (cdr args))
               (box (make-box #f)))

           (parameterize ((profun-op-apply/result#p box))
             (apply procedure arguments))

           (let ((result (box-ref box)))
             (case result
               ((fail) #f)
               ((#f) (cons #t #t))
               (else
                (cons (cons #t result) #t))))))))

(define (profun-apply-return! . args)
  (let ((box (profun-op-apply/result#p)))
    (unless (box? box)
      (raisu 'profun-apply-return-called-outside-of-apply box))
    (box-set! box args)))

(define (profun-apply-fail!)
  (let ((box (profun-op-apply/result#p)))
    (unless (box? box)
      (raisu 'profun-apply-return-called-outside-of-apply box))
    (box-set! box 'fail)))
