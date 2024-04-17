;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:simple:handle-calls rules)
  (define (transform last init)
    (when (null? (cdr last))
      (raisu* :from "parselynn:simple:handle-calls"
              :type 'empty-call-not-allowed
              :message "Call instruction cannot be empty"
              :args (list last init rules)))

    (unless (null? (cdr (cdr last)))
      (raisu* :from "parselynn:simple:handle-calls"
              :type 'multiple-expressions-in-call-not-allowed
              :message "Call instruction cannot have multiple arguments"
              :args (list last init rules)))

    (list (reverse init) ': (cadr last)))

  (define (maybe-transform production)
    (if (null? production) (list '())
        (let ()
          (define rev (reverse production))
          (define last (car rev))
          (if (and (pair? last)
                   (equal? 'call (car last)))
              (transform last (cdr rev))
              (list production)))))

  (bnf-alist:map-productions*
   (lambda (name) maybe-transform)
   rules))
