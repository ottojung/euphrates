;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (olnode-remove-transitive-edges olnode)
  (define closure
    (olnode-transitive-closure/edges olnode))

  (define ret
    (make-olnode (olnode:value olnode)))

  (define H (make-hashset))

  (let loop ((olnode olnode))
    (unless (hashset-has? H (olnode:id olnode))
      (hashset-add! H (olnode:id olnode))
      (let ()
        (define ret
          (make-olnode/full
           (olnode:value olnode)
           '()
           (olnode:meta olnode)))

        (define old-children
          (olnode:children olnode))

        (define (contains-current? current)
          (lambda (child)
            (and (not (olnode-eq? child current))
                 (let ()
                   (define key (cons (olnode:id child)
                                     (olnode:id current)))
                   (not (hashset-has? key))))))

        (define filtered
          (filter
           (lambda (current)
             (list-and-map
              (negate (contains-current? current))
              old-children))
           old-children))

        (define new-children
          0)

        (olnode:children:set! ret new-children)
        ret))))
