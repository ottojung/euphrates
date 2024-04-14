;;;; Copyright (C) 2024, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (olnode-reverse-children-inplace! olnode)
  (let loop ((olnode olnode))
    (define children (olnode:children olnode))
    (olnode:children:set! olnode (reverse children))
    (for-each loop children)))

(define (olgraph-reverse-children-inplace! olgraph)
  (for-each
   olnode-reverse-children-inplace!
   (olgraph:initial olgraph)))
