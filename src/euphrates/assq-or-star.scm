;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-syntax assq-or*
  (syntax-rules ()
    ((_ keylist alist)
     (assq-or* keylist alist #f))
    ((_ keylist alist default)
     (let loop ((keylist* keylist)
                (current alist))
       (cond
        ((null? keylist*) current)
        ((list? current)
         (let* ((key (car keylist*))
                (got (assq key current)))
           (if got
               (loop (cdr keylist*)
                     (cdr got))
               default)))

        (else
         (raisu 'type-error "Expected an alist but got something else"
                keylist* current)))))))
