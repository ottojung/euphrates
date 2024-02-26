;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define-type9 olgraph
  (olgraph-constructor id value children meta) olgraph?
  (id olgraph:id)
  (value olgraph:value)
  (children olgraph:children olgraph:children:set!)
  (meta olgraph:meta olgraph:meta:set!)
  )


(define make-olgraph
  (let ()
    (define counter 0)
    (lambda (value children meta)
      (define id counter)
      (set! counter (+ 1 counter))
      (olgraph-constructor id value children meta))))
