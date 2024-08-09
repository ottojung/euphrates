;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;
;; This procedure computes the FIRST set of a context-free grammar.
;; In result FIRST(A) is the set of terminals which can appear
;; as the first element of any chain of rules matching nonterminal A.
;;

;;
;; Given a context-free grammar G = (N, T, P, S):
;; - N is the set of non-terminals,
;; - T is the set of terminals,
;; - P is the set of production rules,
;; - S is the start symbol.
;;
;; The "FIRST" set can be defined axiomatically as follows:
;;
;; 1. **Initialization:**
;;    - For each terminal 'a' in T, FIRST(a) = {a}.
;;    - For the empty string epsilon, FIRST(epsilon) = {epsilon}.
;;    - For each non-terminal A in N, start with FIRST(A) = {}.
;;
;; 2. **Production Rule Iteration:**
;;    (x) For each production rule A -> alpha (where A is a non-terminal and alpha is a sequence of terminals/non-terminals),
;;      (y) Go through each symbol X in alpha from left to right and:
;;        (a) If X is a terminal, add X to FIRST(A) and stop processing further symbols in alpha.
;;        (b) If X is a non-terminal, add all elements of FIRST(X) except epsilon to FIRST(A).
;;           (i)  If epsilon is in FIRST(X) (i.e., X can derive the empty string), continue to the next symbol in alpha.
;;           (ii) If epsilon is not in FIRST(X), stop processing further symbols in alpha.
;;
;; 3. **Completion:**
;;    - If alpha can derive epsilon (i.e., all symbols in alpha can produce epsilon), then add epsilon to FIRST(A).
;;
;; 4. **Fixpoint:**
;;    - Repeat steps 3 and 4 until no more changes occur to any FIRST(A).
;;

(define (bnf-alist:compute-first-set grammar)
  (define table (make-hashmap))

  (define (epsilon? X)
    (equal? parselynn:epsilon X))

  (define (add-to-first! key value)
    (define existing (hashmap-ref table key #f))
    (define existing* (or existing (make-hashset)))
    (define added-before? (hashset-has? existing* value))
    (unless existing (hashmap-set! table key existing*))
    (unless added-before?
      (hashset-add! existing* value))
    added-before?)

  (define (get-from-first key)
    (cond
     ((terminal? key)
      (hashmap-ref
       terminal-first key))
     ((epsilon? key)
      epsilon-first)
     (else
      (hashmap-ref table key))))

  (define terminals
    (list->hashset
     (bnf-alist:terminals grammar)))

  (define nonterminals
    (list->hashset
     (bnf-alist:nonterminals grammar)))

  (define (terminal? X)
    (hashset-has? terminals X))

  (define (nonterminal? X)
    (hashset-has? nonterminals X))

  ;;
  ;; 1. **Initialization**
  ;;

  (define terminal-first
    (alist->hashmap
     (map
      (lambda (terminal)
        (cons terminal
              (list->hashset (list terminal))))
      (hashset->list
       terminals))))

  (define epsilon-first
    (list->hashset (list parselynn:epsilon)))

  (hashset-foreach
   (lambda (nonterminal)
     (hashmap-set! table nonterminal (make-hashset)))
   nonterminals)

  ;;
  ;; 2. **Production Rule Iteration**
  ;;

  (define calculated-set
    (make-hashset))

  (define (iteration)
    (define change? #f)
    (define (add-to-first+record! A X)
      (unless (add-to-first! A X)
        (set! change? #t)))

    (define (get-first-of A)
      (if (hashset-has? calculated-set A)
          (get-from-first A)
          (let ()
            (define productions
              (bnf-alist:assoc-productions A grammar))
            (hashset-add! calculated-set A)
            (for-each (comp (compute-for-production A)) productions)
            (get-from-first A))))

    (define (handle-X A X)
      (cond
       ((terminal? X) ;; 2.(x)(y)(a)
        (add-to-first+record! A X)
        #t) ;; Stop processing by returning true.

       (else ;; 2.(x)(y)(b)
        (let ()
          (define elements
            (get-first-of X))

          (define has-epsilon?
            (hashset-has? elements parselynn:epsilon))

          (hashset-foreach
           (lambda (X)
             (unless (epsilon? X)
               (add-to-first+record! A X)))
           elements)

          (cond
           (has-epsilon? ;; 2.(x)(y)(b)(i)
            #f) ;; Continue processing by returning false.

           (else  ;; 2.(x)(y)(b)(ii)
            #t)))))) ;; Stop processing by returning true.

    ;; 2.(x)(y)
    (define (compute-for-production A alpha)
      (list-find-first
       (comp (handle-X A))
       #f alpha))

    ;; 2.(x)
    (define (calculate A)
      (comp (compute-for-production A)))

    (hashset-clear! calculated-set)
    (bnf-alist:for-each-production calculate grammar)
    change?)

  ;;
  ;; 3. **Completion**
  ;;

  (define (completion)
    (define change? #f)
    (define (add-to-first+record! A X)
      (unless (add-to-first! A X)
        (set! change? #t)))

    (define (has-epsilon? X)
      (define elements
        (get-from-first X))

      (hashset-has? elements parselynn:epsilon))

    (define (complete-for-production A alpha)
      (when (list-and-map has-epsilon? alpha)
        (add-to-first+record! A parselynn:epsilon)))

    (define (complete A)
      (comp (complete-for-production A)))

    (bnf-alist:for-each-production complete grammar)
    change?)

  ;;
  ;; 4. **Fixpoint**
  ;;

  (let loop ()
    (define step2 (iteration))
    (define step3 (completion))
    (when (or step2 step3)
      (loop)))

  ;;;;;;;;;;;;;;;;;;

  table)
