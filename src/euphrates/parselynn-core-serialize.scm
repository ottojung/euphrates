;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:core:serialize parser)
  (define results-mode (parselynn:core:struct:results parser))
  (define driver-name (parselynn:core:struct:driver parser))
  (define tokens (parselynn:core:struct:tokens parser))
  (define rules (parselynn:core:struct:rules parser))
  (define code-actions (parselynn:core:struct:actions parser))
  (define code (parselynn:core:struct:code parser))

  (define ret

    (zoreslava:serialize
     (with-zoreslava

      (zoreslava:set!
       'cqqn4gukh9w0rx195m2c
       `(quote ,parselynn:core:serialized-typetag))

      (zoreslava:set!
       'vasml2yhpvo1iq0ofir7
       `(quote ,results-mode))

      (zoreslava:set!
       'nx8lw4j8m9qkhnks1lnb
       `(quote ,driver-name))

      (zoreslava:set!
       'ill9vlxm3pyptw40uotx
       `(quote ,tokens))

      (zoreslava:set!
       'qofpa1t73vde5nivj6d9
       `(quote ,rules))

      (zoreslava:set!
       'obs163lvp06p9m10bwjy
       code-actions)

      (zoreslava:set!
       'wgq4fdim7f2kx3zj610r
       `(quote ,code))

      (zoreslava:set!
       'i3bpqtlnzqjz8ileyrpt
       (list code code-actions))

      )))

  ret)
