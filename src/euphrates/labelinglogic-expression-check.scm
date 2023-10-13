;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic::expression::check x)
  (define (fail-expression-check show args)
    (raisu* :from "labelinglogic::expression::check"
            :type 'expression-type-error
            :message (stringf "Type error: ~a." show)
            :args args))

  (cond
   ((symbol? x) 'ok)
   ((list? x)
    (let ()
      (define type (car x))
      (define args (cdr x))
      (cond
       ((equal? 'or type)
        (unless (list-length= 3 x)
          0)))))
   (else
    (fail-expression-check
     "Must be either a symbol or a list." (list x)))))
