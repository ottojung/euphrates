;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic::expression:replace-constants expr replacer-fun)
  (let loop ((expr expr))
    (define type
      (labelinglogic::expression:type expr))

    (cond
     ((equal? 'constant type)
      (replacer-fun expr))

     (else
      (let ()
        (define type (car expr))
        (define args (cdr expr))
        (cond
         ((equal? '= type) expr)
         ((equal? 'r7rs type) expr)
         (else
          (cons type (map loop args)))))))))
