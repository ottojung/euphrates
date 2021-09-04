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
%var profun-op-eval
%var profun-eval-return!
%var profun-eval-fail!

%use (profun-op-eval/result#p) "./profun-op-eval-result-p.scm"
%use (make-box box? box-ref box-set!) "./box.scm"

(define profun-op-eval
  (lambda (args ctx)
    (and (not ctx)
         (not (null? args))
         (not (null? (cdr args)))
         (let ((destination (car args))
               (procedure (cadr args))
               (arguments (cddr args))
               (box (make-box #f)))

           (parameterize ((profun-op-eval/result#p box))
             (let ((result (apply procedure arguments)))
               (and (not (eq? 'fail (box-ref box)))
                    (cons (cons result (cons #t (map (const #t) arguments))) #t))))))))

(define (profun-eval-fail!)
  (let ((box (profun-op-eval/result#p)))
    (unless (box? box)
      (raisu 'profun-eval-return-called-outside-of-eval box))
    (box-set! box 'fail)))
