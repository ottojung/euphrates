;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;
;; This procedure computes the FOLLOW set of a context-free grammar.
;; The FOLLOW set of a non-terminal A, FOLLOW(A), is the set of terminals
;; that can appear immediately to the right of A in some "sentential form".
;;

;;
;; Given a context-free grammar G = (N, T, P, S):
;; - N is the set of non-terminals,
;; - T is the set of terminals,
;; - P is the set of production rules,
;; - S is the start symbol.
;;
;; The "FOLLOW" set can be defined axiomatically as follows:
;;
;; 1. **Initialization:**
;;    - For the start symbol S, add end-of-input marker $ to FOLLOW(S).
;;    - For each non-terminal A in N, start with FOLLOW(A) = {}.
;;
;; 2. **Production Rule Iteration:**
;;    For each production rule A -> alpha (where A is a non-terminal and alpha is a sequence of terminals/non-terminals):
;;    (x) For each position in alpha, consider the symbol B at that position:
;;      (y) Look at the rest of the symbols beta to the right of B.
;;        (a) If beta is empty (i.e. B is the last symbol in alpha), add FOLLOW(A) to FOLLOW(B).
;;        (b) For each symbol X in beta from left to right until a terminal is found or non-terminal without epsilon in its FIRST set:
;;            (i)   If X is terminal, add X to FOLLOW(B) and stop further processing of beta.
;;            (ii)  If X is a non-terminal, add all elements of FIRST(X) except epsilon to FOLLOW(B).
;;               (1) If epsilon is in FIRST(X), continue to the next symbol in beta.
;;               (2) If epsilon is not in FIRST(X), stop processing further symbols in beta.
;;        (c) If all symbols in beta can derive epsilon, add FOLLOW(A) to FOLLOW(B).
;;
;; 3. **Fixpoint:**
;;    - Repeat until no more changes occur to any FOLLOW set.
;;

(define (bnf-alist:compute-follow-set grammar)
  (define table (make-hashmap))  ;; Follow sets are stored in a hash map

  (define epsilon "")
  (define end-of-input "$")

  (define (epsilon? X)
    (equal? epsilon X))

  (define (end-of-input? X)
    (equal? end-of-input X))

  (define (add-to-follow! key value)
    (define existing (hashmap-ref table key #f))
    (define existing* (or existing (make-hashset)))
    (define added-before? (hashset-has? existing* value))
    (unless existing (hashmap-set! table key existing*))
    (unless added-before?
      (hashset-add! existing* value))
    added-before?)

  (define (get-from-follow key)
    (hashmap-ref table key (make-hashset)))

  ;; Convenience functions
  (define terminals (list->hashset (bnf-alist:terminals grammar)))
  (define nonterminals (list->hashset (bnf-alist:nonterminals grammar)))

  (define (terminal? X)
    (hashset-has? terminals X))

  (define (nonterminal? X)
    (hashset-has? nonterminals X))

  ;; Initialize FIRST sets if not already done.
  (define first-sets (bnf-alist:compute-first-set grammar))

  (define (get-first of)
    (hashmap-ref first-sets of (make-hashset)))

  ;;
  ;; 1. **Initialization**
  ;;

  (hashset-foreach
   (lambda (nonterminal)
     (hashmap-set! table nonterminal (make-hashset)))
   nonterminals)

  ;; Start symbol gets end-of-input marker in its FOLLOW set.
  (unless (bnf-alist:empty? grammar)
    (let ()
      (define start-symbol (bnf-alist:start-symbol grammar))
      (add-to-follow! start-symbol end-of-input)))

  ;;
  ;; 2. **Production Rule Iteration**
  ;;

  (define calculated-set (make-hashset))  ;; Keep track of calculated FOLLOW sets

  (define (iteration)
    (define change? #f)

    (define (add-to-follow+record! A X)
      (unless (add-to-follow! A X)
        (set! change? #t)))

    (define (process-follow-rule A alpha)
      (let loop ((alpha alpha))
        (unless (null? alpha)
          (let* ((B (car alpha))
                 (beta (cdr alpha)))
            (cond
             ((nonterminal? B)
              ;; 2.(x)(y)(b)
              (let iterator ((beta beta))
                (unless (null? beta)
                  (let ((X (car beta)))
                    (cond
                     ((terminal? X)
                      (add-to-follow+record! B X)
                      (set! beta '())) ;; Stop processing after terminal.
                     ((nonterminal? X)
                      (let ((first-X (get-first X)))
                        (hashset-foreach
                         (lambda (symbol)
                           (unless (epsilon? symbol)
                             (add-to-follow+record! B symbol)))
                         first-X)
                        (if (hashset-has? first-X epsilon)
                            (iterator (cdr beta))
                            (set! beta '()))))))))

              ;; 2.(x)(y)(a) and supplemental rule 2.(x)(y)(c)
              (when (or (null? beta)
                        (and (not (null? beta))
                             (list-and-map
                              (lambda (symbol)
                                (and (nonterminal? symbol)
                                     (hashset-has? (get-first symbol) epsilon)))
                              beta)))
                (hashset-foreach
                 (lambda (symbol)
                   (add-to-follow+record! B symbol))
                 (get-from-follow A)))))
            (loop (cdr alpha))))))

    (define (compute-for-production A alpha)
      (process-follow-rule A alpha))

    (define (calculate A)
      (comp (compute-for-production A)))

    (hashset-clear! calculated-set)
    (bnf-alist:for-each-production calculate grammar)
    change?)

  ;;
  ;; 3. **Fixpoint**
  ;;

  (let loop ()
    (when (iteration)
      (loop)))

  ;; Return the FOLLOW set table
  table)
