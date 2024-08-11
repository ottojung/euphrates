;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;
;; Compute the possible lookahead symbols for the next items in the closure.
;; This is used to determine which lookahead symbols to use when expanding
;; non-terminals in the closure.
;;
(define (parselynn:lr-item:next-lookaheads terminals nonterminals first-set item)
  (define after-symbols/0
    ;; The symbols after the dot (•).
    (parselynn:lr-item:after-dot item))
  (define after-symbols
    (if (null? after-symbols/0) '()
        (cdr after-symbols/0)))

  (define initial-lookahead
    (parselynn:lr-item:lookahead item))

  (define todo
    ;; The list of symbols after the dot plus the initial lookahead.
    (append after-symbols (list initial-lookahead)))

  ;; Utility functions to check terminal, nonterminal, and end-of-input.
  (define (terminal? X)
    (hashset-has? terminals X))

  (define (nonterminal? X)
    (hashset-has? nonterminals X))

  (define (end-of-input? X)
    (equal? X parselynn:end-of-input))

  ;; Recursive function to determine lookahead symbols.
  (let loop ((todo todo))
    (if (null? todo) '()
        (let ()
          (define this
            (car todo))

          (cond
           ((end-of-input? this)
            ;; If we encounter end-of-input, return it as the lookahead.
            (list this))

           ((terminal? this)
            ;; If the symbol is a terminal, return it as the lookahead.
            (list this))

           ((nonterminal? this)
            (let ()
              (define first
                (hashmap-ref first-set this))

              (define to-add-terminals
                (euphrates:list-sort
                 (hashset->list first)
                 (lambda (a b)
                   (string<? (~s a) (~s b)))))

              ;; If the symbol can derive epsilon, continue processing the next symbols.
              (if (hashset-has? first parselynn:epsilon)
                  (append
                   to-add-terminals
                   (loop (cdr todo)))
                  to-add-terminals)))

           (else
            ;; Raise an error if the symbol is neither terminal, nonterminal, nor end-of-input.
            (raisu-fmt
             'impossible-clhbxse4u96ndqyzkh4z
             (stringf
              "Symbol ~s is neither terminal, nonterminal nor eof."
              this))))))))
