;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn/simple-extract-alist set-key options*)
  (define set/l
    (assq-or set-key options* '()))

  (unless (and (list? set/l)
               (list-and-map pair? set/l))
    (raisu* :from "parselynn/simple"
            :type 'invalid-alist
            :message
            (stringf "The ~s option expected an alist of productions mappings, but found something else"
                     (~a set-key))
            :args (list set-key set/l)))

  (define set-keys (map car set/l))
  (define alist
    (map (fn-cons identity (curry-if pair? car))
         set/l))
  (define h (alist->hashmap alist))
  (define h* (and (not (null? alist)) h))

  (values h* set-keys))
