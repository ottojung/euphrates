;; Helpers for testing derivation paths.

;; convert a path (a list of symbols) to a string; we assume every symbol can be converted by ~a.
(define (string-of-path path)
  (apply string-append (map (lambda (s) (string-append (~a s) " ")) path)))

;; Compare two paths lexicographically.
(define (compare-paths p1 p2)
  (string<? (string-of-path p1) (string-of-path p2)))

;; Given a list of paths, sort them in lexicographic order.
(define (sort-paths paths)
  (euphrates:list-sort paths compare-paths))

;; A test‐case macro for compute-all-paths–from.
(define-syntax test-all-paths-case
  (syntax-rules ()
    ((_ bnf start expected)
     (let* ((result (sort-paths (bnf-alist:compute-all-paths-from bnf start)))
            (expected-sorted (sort-paths expected)))
       (unless (equal? result expected-sorted)
         (debug "\nFor grammar:\n~s\nStarting at: ~s\nExpected derivations:\n~s\nActual derivations:\n~s\n"
                bnf start expected-sorted result))
       (assert= result expected-sorted)))))

;; Test cases:

;; Single production: S → a.
;;    Expected: only one derivation: (S a)
(let ()
  (define bnf '((S (a))))
  (define expected '((S a)))
  (test-all-paths-case bnf 'S expected))

;; Direct dependency.
;;    Grammar:
;;      S → A
;;      A → b
;;    Expected (from S): one derivation: (S A b)
(let ()
  (define bnf '((S (A))
                (A (b))))
  (define expected '((S A b)))
  (test-all-paths-case bnf 'S expected))

;; Indirect dependency.
;;    Grammar:
;;      S → A
;;      A → B
;;      B → c
;;    Expected (from S): (S A B c)
(let ()
  (define bnf '((S (A))
                (A (B))
                (B (c))))
  (define expected '((S A B c)))
  (test-all-paths-case bnf 'S expected))

;; Two production alternatives.
;;    Grammar:
;;      S → A     | B
;;      A → a
;;      B → b
;;    Expected (from S): two derivations: (S A a) and (S B b)
(let ()
  (define bnf '((S (A) (B))
                (A (a))
                (B (b))))
  (define expected '((S A a)
                     (S B b)))
  (test-all-paths-case bnf 'S expected))

;; Production with a sequence.
;;    Grammar:
;;      S → A B
;;      A → a
;;      B → b
;;    Expected (from S): (S A a B b)
(let ()
  (define bnf '((S (A B))
                (A (a))
                (B (b))))
  (define expected '((S A a B b)))
  (test-all-paths-case bnf 'S expected))

;; Circular dependency.
;;    Grammar:
;;      S → A
;;      A → S
;;      B → d
;;    Expected (from S): when S appears for a second time it is not expanded.
;;      So the unique derivation is: (S A S)
(let ()
  (define bnf '((S (A))
                (A (S))
                (B (d))))
  (define expected '((S A S)))
  (test-all-paths-case bnf 'S expected))

;; More complex grammar with mixed alternatives.
;;    Grammar:
;;      S → A B    | B C
;;      A → a
;;      B → b
;;      C → c
;;    Expected (from S): Two derivations:
;;       (S A a B b) and (S B b C c)
(let ()
  (define bnf '((S (A B) (B C))
                (A (a))
                (B (b))
                (C (c))))
  (define expected '((S A a B b)
                     (S B b C c)))
  (test-all-paths-case bnf 'S expected))

;; A nonterminal with a single epsilon production:
;;    Grammar: S → ε
;;    (signified as an empty production list)
;;    Expected derivation from S: (S)
(let ()
  (define bnf '((S ())))
  (define expected `((S ,parselynn:epsilon)))
  (test-all-paths-case bnf 'S expected))

;; A nonterminal dependent on one that produces epsilon.
;;    Grammar:
;;       S → A
;;       A → ε
;;    Expected derivation from S: (S A)
(let ()
  (define bnf '((S (A))
                (A ())))
  (define expected `((S A ,parselynn:epsilon)))
  (test-all-paths-case bnf 'S expected))

;; Epsilon production in a sequence.
;;    Grammar:
;;       S → A B
;;       A → ε
;;       B → b
;;    Expected: starting from S, the unique derivation is (S A B b)
;;    (A expands via epsilon so no extra terminal is produced, but A is still listed)
(let ()
  (define bnf '((S (A B))
                (A ())
                (B (b))))
  (define expected `((S A ,parselynn:epsilon B b)))
  (test-all-paths-case bnf 'S expected))

;; A nonterminal with alternatives, one of which is epsilon.
;;    Grammar:
;;       S → ε | a
;;    Expected derivations from S: one from the epsilon alternative, and one from the non-epsilon alternative.
(let ()
  (define bnf '((S () (a))))
  (define expected `((S ,parselynn:epsilon) (S a)))
  (test-all-paths-case bnf 'S expected))

;; A more elaborate example mixing epsilon and non-epsilon alternatives.
;;    Grammar:
;;         S → A B   | C
;;         A → ε     | a
;;         B → b
;;         C → ε
;;    Expected:
;;      • From the first alternative S → A B:
;;           - When A → ε, we get: (S A B b)
;;           - When A → a, we get: (S A a B b)
;;      • From the second alternative S → C:
;;           - C → ε yields: (S C)
;;    Thus, the expected set of derivations is:
;;           (S A B b) , (S A a B b) , (S C)
(let ()
  (define bnf '((S (A B) (C))
                (A () (a))
                (B (b))
                (C ())))
  (define expected `((S A ,parselynn:epsilon B b)
                     (S A a B b)
                     (S C ,parselynn:epsilon)))
  (test-all-paths-case bnf 'S expected))

;; Recursive path.
;;    Grammar:
;;      S → A
;;      A → B
;;      B → S
(let ()
  (define bnf '((S (A))
                (A (B))
                (B (S))))
  (define expected '((S A B S)))
  (test-all-paths-case bnf 'S expected))

;; Recursive path.
;;    Grammar:
;;      S → A
;;      A → B
;;      B → S | A
(let ()
  (define bnf '((S (A))
                (A (B))
                (B (S) (A))))
  (define expected '((S A B A) (S A B S)))
  (test-all-paths-case bnf 'S expected))
