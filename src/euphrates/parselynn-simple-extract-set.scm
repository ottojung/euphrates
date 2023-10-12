;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn/simple-extract-set set-key options*)
  (define set/l
    (assq-or set-key options* '()))

  (unless (list? set/l)
    (raisu* :from "parselynn/simple"
            :type 'invalid-set
            :message
            (stringf "The ~s option expected a list of productions, but found something other than a list"
                     (~a set-key))
            :args (list set-key set/l)))

  (define s (list->hashset set/l))
  (define s* (and (not (null? s)) s))

  (values s* set/l))
