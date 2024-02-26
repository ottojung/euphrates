;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (olgraph->adjlist olgraph)
  (apply append
         (map olnode->adjlist
              (olgraph:initial olgraph))))

(define (olnode->adjlist olnode)
  (define H (make-hashset))
  (define S (stack-make))

  (let loop ((olnode olnode))
    (define key (olnode:id olnode))
    (unless (hashset-has? H key)
      (let ()
        (define children (olnode:children olnode))
        (hashset-add! H key)
        (stack-push!
         S (cons (olnode:value olnode)
                 (map olnode:value children)))
        (for-each loop children))))

  (reverse (stack->list S)))
