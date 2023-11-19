;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:simplify-ground-terms expr)
  (define expr0 expr)
  (define type (labelinglogic:expression:type expr))
  (define args (labelinglogic:expression:args expr))

  (define (ensure-ground expr)
    (unless (labelinglogic:expression:ground? expr)
      (raisu* :from "labelinglogic:expression:simplify-ground-terms"
              :type 'not-a-ground-term
              :message (stringf "Expression ~s is not a ground term"
                                (~a expr))
              :args (list expr expr0))))

  (cond
   ((member type (list '= 'r7rs 'constant))
    expr)

   ((member type (list 'tuple 'not))
    (for-each ensure-ground args)
    expr)

   ((equal? type 'and)
    (let ()
      (define rec (map loop args))
      `(* ,@rec)))

   ((equal? type 'or)
    (let ()
      (define-tuple (A B) args)

      

      0))

   (else
    (raisu* :from "labelinglogic:expression:simplify-ground-terms"
            :type 'unknown-expr-type
            :message (stringf "Expression type ~s not recognized"
                              (~a type))
            :args (list type expr)))))
