;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:move-nots-down expression)
  (define (unknown-expr-type type expression)
    (raisu* :from "labelinglogic:expression:move-nots-down"
            :type 'unknown-expr-type
            :message (stringf "Expression type ~s not recognized"
                              (~a type))
            :args (list type expression)))

  (define (move-down-by-1 expression)
    (define type (labelinglogic:expression:type expression))
    (define args (labelinglogic:expression:args expression))

    (debugs type)
    (debugs expression)

    (cond
     ((member type (list 'r7rs '= 'constant))
      (labelinglogic:expression:make
       'not (list expression)))

     ((equal? type 'or)
      (labelinglogic:expression:make
       'and (map move-down-by-1 args)))

     ((equal? type 'and)
      (labelinglogic:expression:make
       'or (map move-down-by-1 args)))

     ((equal? type 'tuple)
      (labelinglogic:expression:make
       'tuple (map move-down-by-1 args)))

     ((equal? type 'not)
      (loop (car args)))

     (else
      (unknown-expr-type type expression))))

  (define (loop expression)
    (define type (labelinglogic:expression:type expression))
    (define args (labelinglogic:expression:args expression))

    (cond
     ((member type (list 'r7rs '= 'constant))
      expression)

     ((member type (list 'or 'and 'tuple))
      (labelinglogic:expression:make
       type (map loop args)))

     ((equal? type 'not)
      (move-down-by-1 (car args)))

     (else
      (unknown-expr-type type expression))))

  (loop expression))
