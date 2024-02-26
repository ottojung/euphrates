;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define-type9 olgraph
  (make-olgraph initial) olgraph?
  (initial olgraph:initial olgraph:initial:set!) ;; Must a superset of all root (source) nodes. The only guaranteed property is that we can get all nodes by traversing these "initial".
  )


(define-type9 olnode
  (olnode-constructor id value children meta) olnode?
  (id olnode:id)
  (value olnode:value)
  (children olnode:children olnode:children:set!)
  (meta olnode:meta olnode:meta:set!)
  )


(define make-olnode
  (let ()
    (define counter 0)
    (lambda (value children meta)
      (define id counter)
      (set! counter (+ 1 counter))
      (olnode-constructor id value children meta))))
