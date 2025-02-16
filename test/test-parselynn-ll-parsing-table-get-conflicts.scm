
;;
;; Define test-case syntax.
;;


(define-syntax test-case
  (syntax-rules ()
    ((_ grammar* expected*)
     (let ()
       (define grammar grammar*)
       (define expected expected*)

       (define table
         (parselynn:ll-compute-parsing-table grammar))

       (define result/raw
         (parselynn:ll-parsing-table:get-conflicts table))

       (define (show-conflict conflict)
         (with-output-stringified
          (parselynn:ll-parse-conflict:print conflict)))

       (define result
         (map show-conflict result/raw))

       (unless (equal? result expected)
         (debug "\nexpected:\n~s\n\n" expected)
         (debug "\nactual:\n~s\n\n" result))

       (assert= result expected)))))


;;;;;;;;;;;;;;;;;
;;
;; Test cases:
;;


(let ()
  ;;
  ;; Empty grammar
  ;;
  ;;   Grammar:
  ;;

  (define grammar
    '())

  (define expected
    '())

  (test-case grammar expected))


(let ()
  ;;
  ;; Empty production
  ;;
  ;;   Grammar:
  ;;
  ;; S -> ε
  ;;

  (define grammar
    '((S ())))

  (define expected
    '())

  (test-case grammar expected))


(let ()
  ;;
  ;; Simple grammar with single production.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> a
  ;;

  (define grammar
    '((S (a))))

  (define expected
    '())

  (test-case grammar expected))


(let ()
  ;;
  ;; Simple LL conflicting grammar.
  ;;
  ;;   Grammar:
  ;;
  ;; S → num a | num b
  ;;
  ;;   Note:
  ;;
  ;; This grammar simply needs left factoring.
  ;;

  (define grammar
    '((S (num a) (num b))))

  (define expected
    `("Conflict between productions \"S ➔ num a\" and \"S ➔ num b\". All of them derive token \"num\" first."))

  (test-case grammar expected))


(let ()
  ;;
  ;; Simple LL conflicting grammar [2].
  ;;
  ;;   Grammar:
  ;;
  ;; S → num a b c | num d e f
  ;;
  ;;   Note:
  ;;
  ;; This grammar simply needs left factoring.
  ;;

  (define grammar
    '((S (num a b c) (num d e f))))

  (define expected
    `("Conflict between productions \"S ➔ num a b c\" and \"S ➔ num d e f\". All of them derive token \"num\" first."))

  (test-case grammar expected))


(let ()
  ;;
  ;; Simple LL non-conflicting grammar.
  ;;
  ;;   Grammar:
  ;;
  ;; S → num S^
  ;; S^ → a b c | d e f
  ;;
  ;;   Note:
  ;;
  ;; This is the left-factored version of the previous grammar.
  ;;

  (define grammar
    '((S (num S^))
      (S^ (a b c) (d e f))))

  (define expected
    `())

  (test-case grammar expected))


(let ()
  ;;
  ;; Nonobvious conflicting grammar [1].
  ;;
  ;;   Grammar:
  ;;
  ;; S → L space split space R.
  ;; L → num | num space L.
  ;; R → num | num space R.
  ;;
  ;;   Notes:
  ;;
  ;; Taken from <https://codeberg.org/otto/euphrates/issues/46>.
  ;; Check here <https://smlweb.cpsc.ucalgary.ca/lr1.php?grammar=S+-%3E+L+space+split+space+R.%0AL+-%3E+num%0A+++%7C+num+space+L.%0AR+-%3E+num%0A+++%7C+num+space+R.%0A&substs=>.
  ;;

  (define grammar
    '((S (L space split space R))
      (L (num) (num space L))
      (R (num) (num space R))))

  (define expected
    `("Conflict between productions \"L ➔ num\" and \"L ➔ num space L\". All of them derive token \"num\" first."
      "Conflict between productions \"R ➔ num\" and \"R ➔ num space R\". All of them derive token \"num\" first."))

  (test-case grammar expected))


(let ()
  ;;
  ;; More than two alternatives, issues with left-factoring.
  ;;
  ;;   Grammar:
  ;;
  ;; S → id op id
  ;; S → xx op id op id
  ;; S → id
  ;;

  (define grammar
    '((S (id op id) (xx op id op id) (id))))
  (define expected
    `("Conflict between productions \"S ➔ id op id\" and \"S ➔ id\". All of them derive token \"id\" first."))

  (test-case grammar expected))


(let ()
  ;;
  ;; Grammar with conflict in a non-start nonterminal.
  ;;
  ;; Grammar:
  ;;   S → A d | b
  ;;   A → a | a A
  ;;
  ;; Explanation:
  ;; The alternatives for A start with the same terminal 'a',
  ;; so the LL(1) parsing table for A should report a conflict on key ‘a’,
  ;; with the two actions being "A← a" and "A← a A".
  ;;

  (define grammar
    '((S (A d) (b))
      (A (a) (a A))))

  (define expected
    `("Conflict between productions \"A ➔ a\" and \"A ➔ a A\". All of them derive token \"a\" first."))

  (test-case grammar expected))


(let ()
  ;;
  ;; Conflict in the start nonterminal.
  ;;
  ;; Grammar:
  ;;   S → a B | a C
  ;;   B → b
  ;;   C → c
  ;;
  ;; Expected conflict on S with key a.
  ;;

  (define grammar
    '((S (a B) (a C))
      (B (b))
      (C (c))))

  (define expected
    `("Conflict between productions \"S ➔ a B\" and \"S ➔ a C\". All of them derive token \"a\" first."))

  (test-case grammar expected))


(let ()
  ;;
  ;; Indirect conflict in a non-start nonterminal.
  ;;
  ;; Grammar:
  ;;   S → A | b
  ;;   A → a | a c
  ;;
  ;; Expected conflict on A with key a.
  ;;

  (define grammar
    '((S (A) (b))
      (A (a) (a c))))

  (define expected
    `("Conflict between productions \"A ➔ a\" and \"A ➔ a c\". All of them derive token \"a\" first."))

  (test-case grammar expected))


(let ()
  ;;
  ;; Conflict in a recursive nonterminal.
  ;;
  ;; Grammar:
  ;;   S → A | b
  ;;   A → a B | a C
  ;;   B → d
  ;;   C → e
  ;;
  ;; Expected conflict in A on key a.
  ;;

  (define grammar
    '((S (A) (b))
      (A (a B) (a C))
      (B (d))
      (C (e))))

  (define expected
    `("Conflict between productions \"A ➔ a B\" and \"A ➔ a C\". All of them derive token \"a\" first."))

  (test-case grammar expected))


(let ()
  ;;
  ;; Three alternatives sharing the same first token.
  ;;
  ;; Grammar:
  ;;   S → x y | x z | x t
  ;;
  ;; Expected conflict on S with key x and three conflicting actions.
  ;;

  (define grammar
    '((S (x y) (x z) (x t))))

  (define expected
    `("Conflict between productions \"S ➔ x y\", \"S ➔ x z\" and \"S ➔ x t\". All of them derive token \"x\" first."))

  (test-case grammar expected))


(let ()
  ;;
  ;; Fully left-factored grammar (should yield no conflicts).
  ;;
  ;; Grammar:
  ;;   S → x S'
  ;;   S' → y | z
  ;;
  ;; Expected: no conflicts.
  ;;

  (define grammar
    '((S (x S'))
      (S' (y) (z))))

  (define expected
    '())

  (test-case grammar expected))


(let ()
  ;;
  ;; Conflict in a helper nonterminal used inside S.
  ;;
  ;; Grammar:
  ;;   S → A B
  ;;   A → p q | p r s
  ;;   B → t
  ;;
  ;; Expected conflict in A on key p.
  ;;

  (define grammar
    '((S (A B))
      (A (p q) (p r s))
      (B (t))))

  (define expected
    `("Conflict between productions \"A ➔ p q\" and \"A ➔ p r s\". All of them derive token \"p\" first."))

  (test-case grammar expected))


(let ()
  ;;
  ;; Multiple nonterminals having conflicts.
  ;;
  ;; Grammar:
  ;;   S → A B
  ;;   A → k | k m
  ;;   B → n | n o
  ;;
  ;; Expected conflicts in A on key k and in B on key n.
  ;;

  (define grammar
    '((S (A B))
      (A (k) (k m))
      (B (n) (n o))))

  (define expected
    `("Conflict between productions \"A ➔ k\" and \"A ➔ k m\". All of them derive token \"k\" first."
      "Conflict between productions \"B ➔ n\" and \"B ➔ n o\". All of them derive token \"n\" first."))

  (test-case grammar expected))


(let ()
  ;;
  ;; Conflict in a self-recursive nonterminal.
  ;;
  ;; Grammar:
  ;;   S → T
  ;;   T → a | a T
  ;;
  ;; Expected conflict in T on key a.
  ;;

  (define grammar
    '((S (T))
      (T (a) (a T))))

  (define expected
    `("Conflict between productions \"T ➔ a\" and \"T ➔ a T\". All of them derive token \"a\" first."))

  (test-case grammar expected))


(let ()
  ;;
  ;; Conflict from productions with similar but not identical right-sides.
  ;;
  ;; Grammar:
  ;;   S → c d e | c d f
  ;;
  ;; Expected conflict in S on key c.
  ;;

  (define grammar
    '((S (c d e) (c d f))))

  (define expected
    `("Conflict between productions \"S ➔ c d e\" and \"S ➔ c d f\". All of them derive token \"c\" first."))

  (test-case grammar expected))


(let ()
  ;;
  ;; Conflict in a nonterminal used in multiple places.
  ;;
  ;; Grammar:
  ;;   S → M a | M b
  ;;   M → x | x y
  ;;
  ;; Expected conflict in M on key x, and, transitively on S.
  ;;

  (define grammar
    '((S (M a) (M b))
      (M (x) (x y))))

  (define expected
    `("Conflict between productions \"S ➔ M a\" and \"S ➔ M b\". All of them derive token \"x\" first."
      "Conflict between productions \"M ➔ x\" and \"M ➔ x y\". All of them derive token \"x\" first."))

  (test-case grammar expected))


(let ()
  ;;
  ;; Multiple conflicting candidates.
  ;;
  ;; Grammar:
  ;;   S → a b | a c | e f | e g | x
  ;;

  (define grammar
    '((S (a b) (a c) (e f) (e g) (x))))

  (define expected
    `("Conflict between productions \"S ➔ a b\" and \"S ➔ a c\". All of them derive token \"a\" first."
      "Conflict between productions \"S ➔ e f\" and \"S ➔ e g\". All of them derive token \"e\" first."))

  (test-case grammar expected))


(let ()
  ;;
  ;; More than two conflicting productions.
  ;;
  ;; Grammar:
  ;;   S → a b | a c | a d | a e
  ;;

  (define grammar
    '((S (a b) (a c) (a d) (a e))))

  (define expected
    `("Conflict between productions \"S ➔ a b\", \"S ➔ a c\", \"S ➔ a d\" and \"S ➔ a e\". All of them derive token \"a\" first."))

  (test-case grammar expected))
