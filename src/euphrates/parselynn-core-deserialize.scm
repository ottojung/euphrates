;;;; Copyright (C) 2023, 2024  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:core:deserialize serialized-vect)
  (define slava
    (zoreslava:deserialize/lists
     serialized-vect))

  (define struct
    (make-parselynn:core:struct
     (zoreslava:ref slava 'vasml2yhpvo1iq0ofir7)
     (zoreslava:ref slava 'nx8lw4j8m9qkhnks1lnb)
     (zoreslava:ref slava 'ill9vlxm3pyptw40uotx)
     (zoreslava:ref slava 'qofpa1t73vde5nivj6d9)
     (zoreslava:ref slava 'obs163lvp06p9m10bwjy)
     (zoreslava:ref slava 'wgq4fdim7f2kx3zj610r)
     (zoreslava:ref slava 'i3bpqtlnzqjz8ileyrpt)
     ))

  struct)
