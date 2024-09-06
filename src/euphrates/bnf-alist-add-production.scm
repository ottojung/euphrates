;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (bnf-alist:add-production bnf-alist production)
  (define lhs (bnf-alist:production:lhs production))
  (define rhs (bnf-alist:production:rhs production))

  (let loop ((rest bnf-alist))
    (if (null? rest)
        (list production)
        (let ()
          (define first (car rest))
          (define first-lhs (bnf-alist:production:lhs first))

          (if (equal? lhs first-lhs)
              (let ()
                (define first-rhss
                  (cdr first))
                (define new
                  (cons
                   first-lhs
                   (append
                    first-rhss (list rhs))))

                (cons new (cdr rest)))

              (cons first (loop (cdr rest))))))))
