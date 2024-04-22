;;;; Copyright (C) 2023, 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:simple:extract-lexer-exprs bnf-alist)
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

  (define (call-expansion? expansion)
    (and (pair? expansion)
         (list-length= 2 expansion)
         (let ()
           (define type (car expansion))
           (equal? type 'call))))

  (define named-terminals
    (let ()
      (define H (make-hashmap))
      (for-each
       (lambda (t)
         (define singleton-t-expansions (list (list t)))
         (for-each
          (lambda (rule)
            (define name (car rule))
            (define expansions (cdr rule))
            (define non-call-expansions
              (map (lambda (expansion) (filter (negate call-expansion?) expansion))
                   expansions))
            (when (equal? singleton-t-expansions non-call-expansions)
              (hashmap-set! H (list 'class name) t)))
          bnf-alist))
       all-terminals)
      H))

  (define (terminal->token t)
    (make-unique-identifier))

  (define (terminal->folexer t)
    t)

  (define tokens-map/0
    (map (compose-under cons terminal->token terminal->folexer)
         all-terminals))

  (define reverse-tokens-map/0
    (map (lambda (p) (cons (cdr p) (car p))) tokens-map/0))

  (define (maybe-translate-terminal x)
    (assoc-or x reverse-tokens-map/0 x))

  (define new-alist
    (bnf-alist:map-expansion-terms
     maybe-translate-terminal bnf-alist))

  (define (dereference-tokens t)
    (let loop ((t t))
      (define existing (hashmap-ref named-terminals t #f))
      (cond
       (existing existing)
       ((list? t) (map loop t))
       (else t))))

  (define tokens-map
    (map (fn-cons identity dereference-tokens)
         tokens-map/0))

  (values new-alist taken-token-names-set tokens-map))
