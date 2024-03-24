;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:to-dnf expr)
  (define expr*
    (labelinglogic:expression:move-nots-down expr))

  (define (make type args)
    (labelinglogic:expression:make type args))

  (define uniq
    (make-unique))

  (define (distribute to-right? expr-1 expr-2)
    (define type-1 (labelinglogic:expression:type expr-1))
    (define args-1 (labelinglogic:expression:args expr-1))
    (define type-2 (labelinglogic:expression:type expr-2))
    (define args-2 (labelinglogic:expression:args expr-2))

    (define result-type
      (if to-right? type-1 type-2))

    (define d-type
      (if to-right? type-2 type-1))

    (define d-args
      (if to-right? expr-2 expr-1))

    (define new-args
      (map
       (lambda (inner)
         (if to-right?
             (make d-type expr-1 inner)
             (make d-type inner expr-2)))
       d-args))

    (make result-type new-args))

  (define (maybe-distribute expr-1 expr-2)
    (define type-1 (labelinglogic:expression:type expr-1))
    (define args-1 (labelinglogic:expression:args expr-1))
    (define type-2 (labelinglogic:expression:type expr-2))
    (define args-2 (labelinglogic:expression:args expr-2))

    (cond
     ((equal? type-2 'or)
      (distribute #t expr-1 expr-2))
     ((equal? type-1 'or)
      (distribute #f expr-2 expr-1))
     (else #f)))

  (define (distribute-args args)
    (let loop ((prev (car args*))
               (rest (cdr args*)))
      (if (null? rest) '()
          (let ()
            (define current (car rest))
            (define follow (cdr rest))
            (define maybe (maybe-distribute prev current))
            (if maybe
                (cons maybe follow)
                (cons prev (loop current follow)))))))

  (let loop ((expr expr*))
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (cond
     ((equal? type 'or) (make type (map loop args)))
     ;; ((equal? type 'and)
     ;;  (if (null? args) expr
     ;;      (let ()
     ;;        (define args* (map loop args))
     ;;        (define c (car args*))
     ;;        (define rest (cdr args*))
     ;;        (if (null? rest) expr
     ;;            (let ()
     ;;              (define next (car rest))
     ;;              (define next-type (labelinglogic:expression:type next))
     ;;              (define next-args (labelinglogic:expression:args next))
     ;;              (define c-type (labelinglogic:expression:type c))
     ;;              (define c-args (labelinglogic:expression:args c))
     ;;              (cond
     ;;               ((equal? next-type 'or)
     ;;                (loop
     ;;                 (make 'or
     ;;                   (map
     ;;                    (lambda (x) (make 'and (list c x)))
     ;;                    next-args))))
     ;;               ((equal? c-type 'or)
     ;;                (loop
     ;;                 (make 'or
     ;;                   (map
     ;;                    (lambda (x) (make 'and (list x next)))
     ;;                    c-args))))
     ;;               (else
     ;;                (make type args*))))))))

     ((equal? type 'and)
      (let ()
        (define args* (map loop args))
        (cond
         ((null? args*) expr)
         ((null? (cdr args*)) expr)
         (else
          (define new-args (distribute-args args*))
          (make type new-args)))))

                  ;; (define next (car rest))
                  ;; (define next-type (labelinglogic:expression:type next))
                  ;; (define next-args (labelinglogic:expression:args next))
                  ;; (define c-type (labelinglogic:expression:type c))
                  ;; (define c-args (labelinglogic:expression:args c))
                  ;; (cond
                  ;;  ((equal? next-type 'or)
                  ;;   (loop
                  ;;    (make 'or
                  ;;      (map
                  ;;       (lambda (x) (make 'and (list c x)))
                  ;;       next-args))))
                  ;;  ((equal? c-type 'or)
                  ;;   (loop
                  ;;    (make 'or
                  ;;      (map
                  ;;       (lambda (x) (make 'and (list x next)))
                  ;;       c-args))))
                  ;;  (else
                  ;;   (make type args*))))))))

     ((member type (list '= 'constant 'r7rs 'tuple 'not)) expr)

     (else
      (raisu* :from "labelinglogic:expression:to-dnf"
              :type 'unknown-expr-type
              :message (stringf "Expression type ~s not recognized"
                                (~a type))
              :args (list type expr))))))
