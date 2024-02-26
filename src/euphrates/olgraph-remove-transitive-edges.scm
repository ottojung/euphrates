;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (olnode-remove-transitive-edges olnode)
  (define closure
    (olnode-transitive-closure/edges olnode))

  (define ret
    (make-olnode (olnode:value olnode)))

  (let loop ((olnode olnode))
    (define old-children
      (olnode:children olnode))

    (define new-children
      0)

    (make-olnode/full
     (olnode:value olnode)
     new-children
     (olnode:meta olnode))))
