;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:to-dnf expr)
  (debugs expr)
  (define ret (labelinglogic:expression:to-dnf/2 expr))
  (debugs ret)
  ret)

(define (labelinglogic:expression:to-dnf/2 expr)
  (define expr*
    (labelinglogic:expression:move-nots-down expr))

  (define (make type args)
    (labelinglogic:expression:make type args))

  (define (distribute to-right? expr-1 expr-2)
    (define type-1 (labelinglogic:expression:type expr-1))
    (define args-1 (labelinglogic:expression:args expr-1))
    (define type-2 (labelinglogic:expression:type expr-2))
    (define args-2 (labelinglogic:expression:args expr-2))

    (define d-args
      (if to-right? args-2 args-1))

    (define new-args
      (map
       (lambda (inner)
         (if to-right?
             (make 'and (list expr-1 inner))
             (make 'and (list inner expr-2))))
       d-args))

    new-args)

  (define (maybe-distribute expr-1 expr-2)
    (define type-1 (labelinglogic:expression:type expr-1))
    (define args-1 (labelinglogic:expression:args expr-1))
    (define type-2 (labelinglogic:expression:type expr-2))
    (define args-2 (labelinglogic:expression:args expr-2))

    (cond
     ((equal? type-2 'or)
      (distribute #t expr-1 expr-2))
     ((equal? type-1 'or)
      (distribute #f expr-1 expr-2))
     (else #f)))

  (define (distribute-args args)
    (let loop ((prev (car args))
               (rest (cdr args)))
      (if (null? rest)
          (list prev)
          (let ()
            (define current (car rest))
            (define follow (cdr rest))
            (define maybe (maybe-distribute prev current))
            (if maybe
                (cons (make 'or maybe) follow)
                (cons prev (loop current follow)))))))

  (let loop ((expr expr*))
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (cond
     ((equal? type 'or) (make type (map loop args)))

     ((equal? type 'and)
      (let ()
        (define args* (map loop args))
        (cond
         ((null? args*) expr)
         ;; ((null? (cdr args*)) expr)
         (else
          (let ()
            (define new-args (distribute-args args*))
            (if (= (length args) (length new-args))
                expr
                (let ()
                  (define ret
                    (if (list-singleton? new-args)
                        (car new-args)
                        (make type new-args)))

                  (loop ret))))))))

     ((member type (list '= 'constant 'r7rs 'tuple 'not)) expr)

     (else
      (raisu* :from "labelinglogic:expression:to-dnf"
              :type 'unknown-expr-type
              :message (stringf "Expression type ~s not recognized"
                                (~a type))
              :args (list type expr))))))
