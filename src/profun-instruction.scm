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

%var profun-instruction-constructor
%var profun-instruction?
%var profun-instruction-sign
%var profun-instruction-args
%var profun-instruction-arity
%var profun-instruction-next
%var profun-instruction-context

%var profun-instruction-build
%var profun-instruction-build/next

%use (define-type9) "./define-type9.scm"

(define-type9 <profun-instruction>
  (profun-instruction-constructor sign args arity next context) profun-instruction?
  (sign profun-instruction-sign) ;; operation signature, like name and version for alternative
  (args profun-instruction-args) ;; arguments
  (arity profun-instruction-arity) ;; arity
  (next profun-instruction-next) ;; link to next `profun-instruction`, or #f is this is the last one
  (context profun-instruction-context) ;; : #f | any
  )

(define (profun-instruction-build/next body next)
  (define rev (reverse body))

  (define (make-one block next)
    (define sign (car block))
    (define args (cdr block))
    (profun-instruction-constructor
     sign args (length args) next #f))

  (define result
    (let lp ((buf rev) (prev next))
      (if (null? buf)
          prev
          (let ((current (make-one (car buf) prev)))
            (lp (cdr buf) current)))))

  result)

;; accepts list of symbols "body"
;; and returns first instruction
(define (profun-instruction-build body)
  (profun-instruction-build/next body #f))
