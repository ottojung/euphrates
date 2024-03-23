;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:empty? model expr)
  (define simple
    (labelinglogic:expression:desugar
     (labelinglogic:expression:move-nots-down expr)))

  (define expr0 expr)

  (let loop ((expr simple))

    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (define _152354736372
      (when (equal? type 'constant)
        (raisu* :from "labelinglogic:expression:empty?"
                :type 'bad-expr-type
                :message (stringf "Expression type ~s not permitted here." (~a type))
                :args (list type expr expr0))))

    (define constants
      (labelinglogic:expression:constants expr))

    (unless (null? constants)
      (raisu* :from "labelinglogic:expression:empty?"
              :type 'contains-bad-types
              :message (stringf "Expression contains type ~s, which is not permitted here." (~a 'constant))
              :args (list 'constant constants expr expr0)))

    (cond
     ((equal? type 'not) #f)
     ((equal? type 'r7rs) #f)
     ((equal? type '=) #t)

     ((equal? type 'and)
      (list-or-map loop args))

     ((member type (list 'tuple 'or 'xor))
      (list-and-map loop args))

     (else
      (raisu* :from "labelinglogic:expression:empty?"
              :type 'unknown-expr-type
              :message (stringf "Expression type ~s not recognized"
                                (~a type))
              :args (list type expression))))))
