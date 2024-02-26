;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (olnode-transitive-closure/edges olnode)
  (define ret (make-hashset))

  (let loop ((olnode olnode) (ancestors (list olnode)))
    (define children (olnode:children olnode))
    (for-each
     (lambda (child)
       (define key (cons olnode child))
       (unless (hashset-has? ret key)
         (for-each
          (lambda (ancestor)
            (define key (cons ancestor key))
            (hashset-add! ret key))
          ancestors)
         (loop child (cons child ancestors))))
     children))

  ret)
