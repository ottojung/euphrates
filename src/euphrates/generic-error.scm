;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (generic-error properties)
  (define properties*
    (cons (cons generic-error:self-key #t)
          (if (and (list? properties)
                   (list-and-map pair? properties))
              properties
              (list (cons generic-error:malformed-key properties)))))

  (define message
    (assq-or generic-error:message-key properties* ""))

  (define irritants-begin
    (assq-or generic-error:irritants-key properties* '()))

  (apply
   error
   (cons message
         (append irritants-begin
                 (list (alist->hashmap/native properties*))))))
