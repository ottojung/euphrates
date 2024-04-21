;;;; Copyright (C) 2023, 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:simple:extract-regexes bnf-alist)
  (define rhss
    (map cdr bnf-alist))

  (define all-expansion-terms
    (apply append (apply append rhss)))

  (define taken-token-names-set
    (list->hashset
     (filter symbol? all-expansion-terms)))

  (define (terminal? x)
    (parselynn:folexer:expression:head? x))

  (define all-terminals
    (list-deduplicate
     (filter terminal? all-expansion-terms)))

  (define (terminal->token t)
    (make-unique-identifier))

  (define terminal->folexer
    (curry-if terminal? identity))

  (define tokens-map
    (map (compose-under cons terminal->token terminal->folexer)
         all-terminals))

  (define reverse-tokens-map
    (map (lambda (p) (cons (cdr p) (car p))) tokens-map))

  (define (maybe-translate-terminal x)
    (assoc-or x reverse-tokens-map x))

  (define new-alist
    (bnf-alist:map-expansion-terms
     maybe-translate-terminal bnf-alist))

  (values new-alist taken-token-names-set tokens-map))
