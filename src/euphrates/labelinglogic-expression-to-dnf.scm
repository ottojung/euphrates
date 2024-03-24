;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:to-dnf expr)
  (define expr*
    (labelinglogic:expression:move-nots-down expr))

  (define (make type args)
    (labelinglogic:expression:make type args))

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
          (let ()
            

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
