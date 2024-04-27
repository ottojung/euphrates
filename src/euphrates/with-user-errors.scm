;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (with-user-errors/func keys body)
  (define (handler err)
    (define p (current-error-port))
    (define default-message "Uknown error.")
    (define message (generic-error:value/unsafe err generic-error:message-key default-message))
    (display message p)
    (newline p)
    (exit 1))

  (catch-many keys body handler))

(define-syntax with-user-errors
  (syntax-rules (:keys)
    ((_ :keys keys . bodies)
     (with-user-errors/func
      keys (lambda _ . bodies)))))
