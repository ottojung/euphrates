;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define (make-check closure)
  (lambda (current)
    (lambda (child)
      (or (olnode-eq? child current)
          (let ()
            (define key (cons (olnode:id child)
                              (olnode:id current)))
            (hashset-has? closure key))))))


(define (olnode-remove-intermediate-edges olnode)
  (olnode-remove-edges/generic make-check olnode))


(define (olgraph-remove-intermediate-edges olgraph)
  (olgraph-remove-edges/generic make-check olgraph))
