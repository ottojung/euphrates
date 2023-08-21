;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (lalr-parser/simple-check-set non-terminals set)
  (define nonexisting-names
    (filter (negate (lambda (x) (memq x non-terminals)))
            (hashset->list set)))

  (unless (null? nonexisting-names)
    (raisu* :from "lalr-parser/simple"
            :type 'invalid-set
            :message
            (stringf "These names: ~a, are expected to be nonterminals, but they aren't"
                     (words->string (map (compose ~s ~a) nonexisting-names)))
            :args (list set))))
