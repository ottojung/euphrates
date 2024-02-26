;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (olnode-remove-intermediate-edges/aux H olnode)
  (define closure
    (olnode-transitive-closure/edges olnode))

  (define ret
    (make-olnode (olnode:value olnode)))

  (debugs (hashset->list closure))

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

          (define (contains-current? current)
            (lambda (child)
              (and (not (olnode-eq? child current))
                   (let ()
                     (define key (cons (olnode:id child)
                                       (olnode:id current)))
                     (not (hashset-has? closure key))))))

          (define filtered
            (filter
             (lambda (current)
               (list-and-map
                (negate (contains-current? current))
                old-children))
             old-children))

          (define new-children
            (map loop filtered))

          (olnode:children:set! ret new-children)

          ret))))


(define (olnode-remove-intermediate-edges olnode)
  (define H (make-hashmap))
  (olnode-remove-intermediate-edges/aux H olnode))


(define (olgraph-remove-intermediate-edges olgraph)
  (define H (make-hashmap))
  (define new-initials
    (map (lambda (node) (olnode-remove-intermediate-edges/aux H node))
         (olgraph:initial olgraph)))
  (make-olgraph new-initials))
