;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:desugar expr)
  (define type
    (labelinglogic:expression:type expr))

  (cond
   ((equal? 'or type)
    (let ()
      (define linearized
        (labelinglogic:expression:args
         (labelinglogic:expression:sugarify expr)))

      (define folded
        (let loop ((rest linearized))
          (cond
           ((or (null? rest)
                (null? (cdr rest))
                (null? (cddr rest)))
            (labelinglogic:expression:make
             type rest))
           (else
            (labelinglogic:expression:make
             type (list (car rest) (loop (cdr rest))))))))

      folded))

    (else expr)))
