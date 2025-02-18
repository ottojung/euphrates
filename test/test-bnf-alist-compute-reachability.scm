
;;
;; For testing we turn the resulting hashmap into an association list of the form:
;;
;;   ((S (sorted-list-of reachable nonterminals))
;;    (A (sorted-list-of reachable nonterminals))
;;    ...)
;;
;; and then compared with the expected result.
;;

;; Helper: sort a list of symbols according to their string values.
(define (sort-symbol-list lst)
  (euphrates:list-sort
   lst (lambda (a b)
         (string<? (~a a)
                   (~a b)))))


;; Helper: Given a mapping (hashmap) from nonterminal->hashset,
;; convert it into an association list where the value in each pair is a sorted list.
(define (mapping->sorted-alist mapping)
  (define alist '())

  (hashmap-foreach
   (lambda (nt hset)
     (set! alist (cons (cons nt (sort-symbol-list (hashset->list hset))) alist)))
   mapping)

  ;; sort the alist by nonterminal names
  (euphrates:list-sort
   alist (lambda (p1 p2)
           (string<? (~a (car p1))
                     (~a (car p2))))))


;; Define a simple testing macro.
(define-syntax test-case
  (syntax-rules ()
    ((_ bnf expected)
     (let ()
       (define result
         (mapping->sorted-alist
          (bnf-alist:compute-reachability bnf)))

       (define expected-sorted
         (euphrates:list-sort

          (map (lambda (p)
                 (cons (car p) (sort-symbol-list (cdr p))))
               expected)

          (lambda (p1 p2)
            (string<? (~s (car p1))
                      (~s (car p2))))))

       (unless (equal? result expected-sorted)
         (debug "\nFor_grammar:\n~s\nExpected:\n~s\nActual:\n~s\n"
                bnf expected-sorted result))

       (assert= result expected-sorted)))))


;;; Test cases:

;; Empty grammar.
(let ()
  (define bnf '())
  (define expected '())
  (test-case bnf expected))

;; A grammar with a single nonterminal that does not invoke any other.
;;
;; Grammar:
;;    S → a
;;
;; Expected: S has no reachable nonterminals.
(let ()
  (define bnf '((S (a))))
  (define expected '((S a)))
  (test-case bnf expected))

;;
;; Direct dependency.
;;
;; Grammar:
;;    S → A
;;    A → b
;;
;; Here A is referenced by S.
;;
(let ()
  (define bnf '((S (A))
                (A (b))))
  (define expected
    '((A b)
      (S A b)))
  (test-case bnf expected))

;;
;; Indirect dependency.
;;
;; Grammar:
;;    S → A
;;    A → B
;;    B → c
;;
;; Expected: S can reach A directly and B indirectly; A reaches B; B reaches nothing.
;;
(let ()
  (define bnf '((S (A))
                (A (B))
                (B (c))))
  (define expected '((A B c)
                     (B c)
                     (S A B c)))
  (test-case bnf expected))

;;
;; Multiple symbols in a production.
;;
;; Grammar:
;;    S → A B
;;    A → C
;;    B → C D
;;    C → E
;;    D → f
;;    E → g
;;
;; Expected:
;;   S: direct {A, B}; indirect from A gives {C, E} and from B gives {C, D, E}.
;;   Thus S reaches {A, B, C, D, E}.
;;   A reaches {C, E};
;;   B reaches {C, D, E};
;;   C reaches {E}; D and E reach nothing.
;;
(let ()
  (define bnf '((S (A B))
                (A (C))
                (B (C D))
                (C (E))
                (D (f))
                (E (g))))
  (define expected `((A C E g)
                     (B C D E f g)
                     (C E g)
                     (D f)
                     (E g)
                     (S A B C D E f g)))
  (test-case bnf expected))

;;
;; Circular dependency.
;;
;; Grammar:
;;    S → A
;;    A → S
;;    B → d
;;
;; Expected: S and A reach each other. (Self-dependency may be added by the propagation.)
;; Depending on the algorithm, both S and A will eventually be augmented with one another.
;; We expect that both S and A have {A, S} as reachable.
;;
(let ()
  (define bnf '((S (A))
                (A (S))
                (B (d))))
  (define expected `((A A S)
                     (B d)
                     (S A S)))
  (test-case bnf expected))

;;
;; Nonterminal with multiple productions.
;;
;; This is the missing case. Here a nonterminal has two different productions.
;;
;; Grammar:
;;    S → A | B
;;    A → x
;;    B → y z
;;
;; Expected: For S, the direct reachable symbols should include both A and B; then,
;; collecting reachability: from A, add x (if x is considered reachable, according to your
;; interpretation), and from B add y and z.
;;
(let ()
  (define bnf '((S (A) (B))
                (A (x))
                (B (y z))))
  (define expected
    ;; Here we assume that the reachable set of S is: {A, B, x, y, z}
    ;; A reaches x; B reaches y and z.
    '((A x)
      (B y z)
      (S A B x y z)))
  (test-case bnf expected))

;;
;; A nonterminal with multiple productions where productions have overlapping dependencies.
;;
;; Grammar:
;;    S → A B  | A C
;;    A → M
;;    B → d
;;    C → e
;;    M → f
;;
;; Expected: S directly reaches A, B, and C; then through A it reaches M, so S should also include M.
;;
(let ()
  (define bnf '((S (A B) (A C))
                (A (M))
                (B (d))
                (C (e))
                (M (f))))
  (define expected
    '((M f)
      (A M f)
      (B d)
      (C e)
      (S A B C M d e f)))
  (test-case bnf expected))
