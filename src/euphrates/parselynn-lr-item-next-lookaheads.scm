;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:lr-item:next-lookaheads terminals nonterminals first-set item)
  (define after-symbols/0
    (parselynn:lr-item:after-dot item))
  (define after-symbols
    (if (null? after-symbols/0) '()
        (cdr after-symbols/0)))

  (define initial-lookahead
    (parselynn:lr-item:lookahead item))

  (define todo
    (append after-symbols (list initial-lookahead)))

  (define (terminal? X)
    (hashset-has? terminals X))

  (define (nonterminal? X)
    (hashset-has? nonterminals X))

  (define (end-of-input? X)
    (equal? X parselynn:end-of-input))

  (let loop ((todo todo))
    (if (null? todo) '()
        (let ()
          (define this
            (car todo))

          (cond
           ((end-of-input? this)
            (list this))

           ((terminal? this)
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

              (if (hashset-has? first parselynn:epsilon)
                  (append
                   to-add-terminals
                   (loop (cdr todo)))
                  to-add-terminals)))

           (else
            (raisu-fmt
             'impossible-clhbxse4u96ndqyzkh4z
             (stringf
              "Symbol ~s is neither terminal, nonterminal nor eof."
              this))))))))
