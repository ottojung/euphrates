;;;; Copyright (C) 2020, 2021, 2022, 2023  Otto Jung
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
  (define-module (euphrates profun-instruction)
    :export (profun-instruction-constructor profun-instruction? profun-instruction-name profun-instruction-body profun-instruction-args profun-instruction-arity profun-instruction-next profun-instruction-context profun-instruction-build profun-instruction-build/next)
    :use-module ((euphrates define-type9) :select (define-type9)))))




(define-type9 <profun-instruction>
  (profun-instruction-constructor name body args arity next context) profun-instruction?
  (name profun-instruction-name)
  (body profun-instruction-body)
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
     sign #f args (length args) next #f))

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
