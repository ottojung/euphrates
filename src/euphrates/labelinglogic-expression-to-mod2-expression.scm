;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; Beware that the resulting expression may be exponentially big!
(define (labelinglogic:expression->mod2-expression expr)
  (let loop ((expr expr))
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
      (cond
       ((equal? (length args) 0) '(+))
       ((equal? (length args) 1) (loop (car args)))
       (else
        (let ()
          (define-values (A1 A2)
            (let ()
              (define pre-A (car args))
              (if (and (pair? pre-A)
                       (equal? '+ (car pre-A)))
                  (values (cdr pre-A) pre-A)
                  (let ()
                    (define rec (loop pre-A))
                    (values (list rec) rec)))))

          (define B (loop (cadr args)))
          (define rest (cddr args))
          (define current `(+ ,@A1 ,B (* ,A2 ,B)))
          (loop
           (labelinglogic:expression:make
            'or (cons current rest)))))))

     ((member type (list '+ '= 'tuple 'r7rs 'constant))
      expr)

     (else
      (raisu* :from "labelinglogic:expression->mod2-expression"
              :type 'unknown-expr-type
              :message (stringf "Expression type ~s not recognized"
                                (~a type))
              :args (list type expr))))))
