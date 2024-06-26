;;;; Copyright (C) 2023, 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:simple:check-set non-terminals set-list)
  (define nonexisting-names
    (filter (negate (comp (hashset-has? non-terminals)))
            set-list))

  (unless (null? nonexisting-names)
    (raisu* :from "parselynn:simple"
            :type 'invalid-set
            :message
            (stringf "These names: ~a, are expected to be nonterminals, but they aren't"
                     (words->string (map (compose ~s ~a) nonexisting-names)))
            :args (list set-list))))
