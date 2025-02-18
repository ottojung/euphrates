
;; Here we assume that the library under test has already defined:
;;  parselynn:build-nullable-prefix-grammar, parselynn:take-nullable-prefix,
;;  and that helpers such as bnf-alist:first-set, bnf-alist:for-each-production,
;;  list-take-until, stack-make, stack-push!, stack->list and the constant
;;  parselynn:epsilon are available.
;;
;; This test file exercises a number of cases.

;; Define a simple testing macro.
(define-syntax test-case
  (syntax-rules ()
    ((_ bnf expected)
     (let ()
       (define result
         (parselynn:build-nullable-prefix-grammar bnf))

       (unless (equal? result expected)
         (debug "\nExpected:\n~s\nActual:\n~s\n" expected result))

       (assert= result expected)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Test cases:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; Empty grammar.
;;
(let ()
  (define bnf '())
  (define expected '())
  (test-case bnf expected))

;;
;; A single nonterminal with one production that is empty (i.e. ε).
;; Grammar: S → ε
;;
(let ()
  (define bnf
    '((S ())))
  ;; For each production, the nullable prefix is empty.
  (define expected
    '((S ())))
  (test-case bnf expected))

;;
;; A grammar mixing nonterminals that are and are not nullable.
;;
;; Grammar:
;;   S → A c
;;   A → ε
;;
;; Assume that terminals (like c) are not nullable and that by having
;; an empty production, A is nullable (its first‐set contains parselynn:epsilon).
;; For the S production: take-nullable-prefix examines the right–hand side (A c).
;; Since A is nullable (by virtue of its production being empty) the prefix is (A)
;; and then stops when encountering c.
;;
(let ()
  (define bnf
    '((S (A c))
      (A ())))
  (define expected
    '((S (A c))   ;; For production S → (A c) the prefix is (A)
      (A ())))  ;; For the only production of A, the prefix is empty.
  (test-case bnf expected))

(let ()
  (define bnf
    '((S (A c d e f))
      (A ())))
  (define expected
    '((S (A c))   ;; For production S → (A c) the prefix is (A)
      (A ())))  ;; For the only production of A, the prefix is empty.
  (test-case bnf expected))

;;
;; A grammar where a nonterminal has two productions.
;;
;; Grammar:
;;   X → Y Z   | Y w
;;   Y → ε
;;   Z → z
;;
;; For both X productions the nullable prefix is (Y) (because Y is nullable,
;; Z and w are terminals or non‑nullable).
;;
(let ()
  (define bnf
    '((X (Y Z) (Y w))
      (Y ())
      (Z (z))))
  (define expected
    `((X (Y Z) (Y w))
      (Y ())
      (Z (z))))
  (test-case bnf expected))

;;
;; A production whose first symbol is terminal.
;;
;; Grammar:
;;   S → a b
;;
;; Here a (a terminal) is assumed not to be nullable so the prefix is empty.
;;
(let ()
  (define bnf
    '((S (a b))))
  (define expected
    '((S (a))))
  (test-case bnf expected))

;;
;; A production in which all symbols are nullable.
;;
;; Grammar:
;;   A → B C
;;   B → ε
;;   C → ε
;;
;; Then for A → (B C) the nullable prefix is the entire RHS, i.e. (B C).
;;
(let ()
  (define bnf
    '((A (B C))
      (B ())
      (C ())))
  (define expected
    '((A (B C))
      (B ())
      (C ())))
  (test-case bnf expected))

;;
;; A production where the very first nonterminal is not nullable.
;;
;; Grammar:
;;   S → D E
;;   D → (d)         ;; d is a terminal, so D is not nullable.
;;   E → ε
;;
;; For S → (D E), because D is not nullable, the nullable prefix is empty.
;;
(let ()
  (define bnf
    '((S (D E))
      (D (d))
      (E ())))
  (define expected
    '((S (D))
      (D (d))
      (E ())))
  (test-case bnf expected))
