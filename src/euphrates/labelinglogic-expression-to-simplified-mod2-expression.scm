;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression->simplified-mod2-expression expr)
  (define sugarified
    (labelinglogic:expression:sugarify expr))

  (define translated
    (let loop ((expr sugarified))
      (define type (labelinglogic:expression:type expr))
      (define args (labelinglogic:expression:args expr))

      (cond
       ((equal? type 'and)
        (let ()
          (define rec (map loop args))
          `(* ,@rec)))

       ((equal? type 'not)
        (let ()
          (define-tuple (arg) args)
          (define rec (loop arg))
          `(+ 1 ,rec)))

       ((equal? type 'or)
        (let ()
          (define-tuple (A B) args)
          `(+ ,A ,B (* ,A ,B))))

       ((equal? type 'xor)
        (let ()
          (define-tuple (A B) args)
          `(+ ,A ,B)))

       ((equal? type 'tuple)
        (cons 'tuple (map loop args)))

       ((member type (list '= 'r7rs 'constant))
        expr)

       (else
        (raisu* :from "labelinglogic:expression->mod2-expression"
                :type 'unknown-expr-type
                :message (stringf "Expression type ~s not recognized"
                                  (~a type))
                :args (list type expr))))))

  translated)
