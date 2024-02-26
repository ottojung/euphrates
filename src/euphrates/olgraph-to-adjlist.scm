;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (olnode->adjlist olnode)
  (define H (make-hashmap))
  (define ret (stack-make))

  (let loop ((olnode olnode))
    (define children (olnode:children olnode))
    (for-each
     (lambda (child)
       (define key (cons olnode child))
       (unless (hashset-has? H key)
         (let ()
           (loop child (cons (olnode:id child) ancestors)))))
     children))

  (reverse (stack->list ret)))
