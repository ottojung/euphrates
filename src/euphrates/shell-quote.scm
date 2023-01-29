;;;; Copyright (C) 2021  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; version 3 of the License.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

%run guile

;; Uses single quotes, and puts single quotes into double quotes,
;; so the string $'b is quoted as '$'"'"'b'
%var shell-quote
%var shell-quote/always/list

%use (shell-safe/alphabet/index) "./shell-safe-alphabet.scm"

(define (shell-quote/always/list lst)
  (list->string
   (cons #\'
         (let loop ((lst lst))
           (if (null? lst)
               '(#\')
               (let ((x (car lst)))
                 (if (equal? #\' x)
                     (cons #\' (cons #\" (cons #\' (cons #\" (cons #\' (loop (cdr lst)))))))
                     (cons x (loop (cdr lst))))))))))

(define (shell-quote str)
  (define lst (string->list str))
  (if (null? (filter (negate shell-safe/alphabet/index) lst))
      str
      (shell-quote/always/list lst)))

