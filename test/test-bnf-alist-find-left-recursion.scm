
;; Helper: convert a left–recursion structure into a pair:
(define (left-recursion->pair lr)
  (list (bnf-alist:left-recursion:nonterminal lr)
        (bnf-alist:left-recursion:cycle lr)))

(define (string-of-path path)
  (words->string (map ~s path)))

;; A helper to compare two left–recursion “pairs.”
;; We compare first the nonterminal symbols (using ~a to convert to strings)
;; If they’re equal, then we compare the cycles (which are derivation paths, and so we use our
;; already–defined string-of-path procedure to convert the list to a string).
(define (compare-left-recursion lr1 lr2)
  (let* ((nt1 (car lr1))
         (nt2 (car lr2))
         (s1 (~s nt1))
         (s2 (~s nt2)))
    (if (string=? s1 s2)
        (string<? (string-of-path (cadr lr1))
                  (string-of-path (cadr lr2)))
        (string<? s1 s2))))

;; A helper to sort a list of left–recursion pairs.
(define (sort-left-recursion lr-list)
  (euphrates:list-sort lr-list compare-left-recursion))

;; A test–case macro inspired by the one for paths.
(define-syntax test-left-recursion-case
  (syntax-rules ()
    ((_ bnf expected)
     (let* ((bnf bnf)
            (result (bnf-alist:find-left-recursion bnf))
            (result-pairs (sort-left-recursion (map left-recursion->pair result)))
            (expected-pairs (sort-left-recursion expected)))
       (unless (equal? result-pairs expected-pairs)
         (debug "\nFor grammar:\n~s\nExpected left recursion pairs:\n~s\nActual pairs:\n~s\n"
                bnf expected-pairs result-pairs))
       (assert= result-pairs expected-pairs)))))

;; Grammar with no left recursion.
;;    Grammar:
;;      S → a
;;      A → b
;;    Expected: No left recursion detected.
(let ()
  (define grammar-no-recur '((S (a))
                             (A (b))))
  (test-left-recursion-case grammar-no-recur '()))

;; Grammar with a direct (immediate) left recursion.
;;    Grammar:
;;      S → S a    | a
;;    Expected: the derivation from S using the left–recursive alternative is (S S a)
(let ()
  (define grammar-direct '((S (S a) (a))))
  (define expected '((S (S S a))))  ; note: the cycle is the derivation path starting with S and then again S before terminal a.
  (test-left-recursion-case grammar-direct expected))

;; Grammar with an indirect left recursion.
;;    Grammar:
;;       S → A
;;       A → S
;;    Expected:
;;       * From S, the sole derivation is (S A S)
;;       * From A, the sole derivation is (A S A)
(let ()
  (define grammar-indirect '((S (A))
                             (A (S))))
  (define expected '((S (S A S))
                     (A (A S A))))
  (test-left-recursion-case grammar-indirect expected))

;; Grammar where one nonterminal recurses on itself though it’s not the start symbol.
;;    Grammar:
;;       S → A
;;       A → A    | a
;;    Expected:
;;       * Although S is not left–recursive, A is: (A A)
(let ()
  (define grammar-A-only '((S (A))
                           (A (A) (a))))
  (define expected '((A (A A))))
  (test-left-recursion-case grammar-A-only expected))

;; Grammar with multiple left–recursive alternatives.
;;    Grammar:
;;       S → S a   | S b
;;    Expected:
;;       Two left–recursive derivations from S:
;;         (S S a) and (S S b)
(let ()
  (define grammar-multi '((S (S a) (S b))))
  (define expected '((S (S S a))
                     (S (S S b))))
  (test-left-recursion-case grammar-multi expected))

;; Epsilon in a left–recursive alternative.
;;
;; Grammar:
;;     S → S      | ε
;;
;; Here S has two alternatives. Only the first one is left–recursive.
;; In our representation, the epsilon production is written as an empty list.
;; For the left–recursive alternative, the derivation proceeds as follows:
;;  • Starting from S (with visited = ())
;;  • Expanding production (S): the call to derive-sym sees that S is already in
;;    the visited list and returns a cycle (S S).
;;  • The epsilon alternative (()) does not yield a cycle.
;;
;; Expected left recursion:
;;   for S, the unique left–recursive cycle is: (S S)
(let ()
  (define grammar-epsilon '((S (S) ())))
  (define expected-epsilon '((S (S S))))
  (test-left-recursion-case grammar-epsilon expected-epsilon))

;; Multiple left–recursive alternatives from the same nonterminal.
;;
;; Grammar:
;;     S → S a  | A
;;     A → S b  | a
;;
;; Analysis:
;;   • Starting from S:
;;        – Production (S a) leads immediately to a cycle.
;;          • S → S a yields derivation: (S S a)
;;
;;        – Production (A) expands A (with visited updated to (S)) and then uses
;;          alternative (S b); here, when expanding S the fact that S is already
;;          in the visited list causes a cycle:
;;          • S → A, A → S b yields derivation: (S A S b)
;;
;; Expected left recursion for S: two structures, one for cycle (S S a) and one for (S A S b).
(let ()
  (define grammar-multi '((S (S a) (A))
                          (A (S b) (a))))
  (define expected-multi '((A (A S A b))
                           (S (S A S b))
                           (S (S S a))))
  (test-left-recursion-case grammar-multi expected-multi))

;; Indirect left–recursion by way of three different nonterminals.
;;
;; Grammar:
;;     S → A
;;     A → B
;;     B → S a  | b
;;
;; Analysis:
;;   Starting from S:
;;    • S → A, visited becomes (S)
;;    • A → B, visited becomes (A S)
;;    • B → S a:
;;           When expanding S in B (with visited = (B A S)), S is already in the visited list.
;;           Therefore, one cycle produced is (S A B S a).
;;
;; Notice that B’s other alternative (b) does not yield a cycle. Also, only S gets a recursive cycle.
(let ()
  (define grammar-indirect '((S (A))
                              (A (B))
                              (B (S a) (b))))
  (define expected-indirect '((A (A B S A a))
                              (B (B S A B a))
                              (S (S A B S a))))
  (test-left-recursion-case grammar-indirect expected-indirect))
