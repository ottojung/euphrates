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

%run guile

;; In order to return result during apply evaluation, call `profun-apply-return!';
;; in order to fail, call `profun-apply-fail!'.
%var profun-op-eval
%var profun-eval-return!
%var profun-eval-fail!

%use (box-ref box-set! box? make-box) "./box.scm"
%use (profun-ctx-set profun-set) "./profun-accept.scm"
%use (profun-op-eval/result#p) "./profun-op-eval-result-p.scm"
%use (profun-reject) "./profun-reject.scm"
%use (profun-variable-arity-op) "./profun-variable-arity-op.scm"
%use (raisu) "./raisu.scm"

(define profun-op-eval
  (profun-variable-arity-op
   (lambda (args ctx)
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
                    ([0] <- result)
                    (profun-ctx-set #t))))))))))

(define (profun-eval-fail!)
  (let ((box (profun-op-eval/result#p)))
    (unless (box? box)
      (raisu 'profun-eval-return-called-outside-of-eval box))
    (box-set! box 'fail)))
