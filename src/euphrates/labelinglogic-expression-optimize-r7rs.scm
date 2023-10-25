;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:optimize/r7rs expr)
  (define-tuple (code) (labelinglogic:expression:args expr))

  (define (is-application? code)
    (and (list? code)
         (pair? code)))

  (define (unpack-application code)
    (values (car code) (cdr code)))

  (define (pack-application fun inputs)
    (cons fun inputs))

  (define (is-lambda? code)
    (and (list? code)
         (list-length= 3 code)
         (equal? 'lambda (car code))))

  (define (unpack-lambda code)
    (values (list-ref code 1)
            (list-drop-n 2 code)))

  (define (pack-lambda inputs bodies)
    (cons 'lambda (cons inputs bodies)))

  (define (is-or? code)
    (and (list? code)
         (not (null? code))
         (equal? 'or (car code))))

  (define (unpack-or code)
    (cdr code))

  (define (pack-or args)
    (cons 'or args))

  (define (loop code)
    (cond
     ((is-lambda? code)
      (let ()
        (define-values (args bodies) (unpack-lambda code))
        (pack-lambda args (map loop bodies))))

     ((is-or? code)
      (let ()
        (define sugared (labelinglogic:expression:sugarify code))
        (assert (is-or? sugared))
        (define args (unpack-or sugared))
        (pack-or (map loop args))))

     ((is-application? code)
      (let ()
        (define-values (lam inputs) (unpack-application code))
        (cond
         ((is-lambda? lam)
          (let ()
            (define-values (arguments bodies) (unpack-lambda lam))

            (define body*
              (if (list-singleton? bodies)
                  (car bodies)
                  `(let () ,@bodies)))

            (if (equal? arguments inputs)
                (loop body*)
                (pack-application
                 (pack-lambda arguments (map loop bodies))
                 inputs))))

         (else
          (pack-application (loop lam) (map loop inputs))))))

     (else code)))

  (list 'r7rs (apply-until-fixpoint loop code)))
