;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (make-check closure)
  (lambda (child)
    (lambda (other)
      (or (olnode-eq? other child)
          (let ()
            (define key (cons (olnode:id other)
                              (olnode:id child)))
            (not (hashset-has? closure key)))))))

(define (olnode-remove-transitive-edges/aux H olnode)
  (define closure
    (olnode-transitive-closure/edges olnode))

  (define keep?
    (make-check closure))

  (define ret
    (make-olnode (olnode:value olnode)))

  (let loop ((olnode olnode))
    (define existing (hashmap-ref H (olnode:id olnode) #f))
    (or existing
        (let ()
          (define ret
            (make-olnode/full
             (olnode:value olnode)
             '()
             (olnode:meta olnode)))

          (define _182313
            (hashmap-set! H (olnode:id olnode) ret))

          (define old-children
            (olnode:children olnode))

          (define filtered
            (filter
             (lambda (child)
               (list-and-map (keep? child) old-children))
             old-children))

          (define new-children
            (map loop filtered))

          (olnode:children:set! ret new-children)

          ret))))


(define (olnode-remove-transitive-edges olnode)
  (define H (make-hashmap))
  (olnode-remove-transitive-edges/aux H olnode))


(define (olgraph-remove-transitive-edges olgraph)
  (define H (make-hashmap))
  (define new-initials
    (map (lambda (node) (olnode-remove-transitive-edges/aux H node))
         (olgraph:initial olgraph)))
  (make-olgraph new-initials))
