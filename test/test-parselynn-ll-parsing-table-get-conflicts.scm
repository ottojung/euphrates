
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

       (define (action->string action)
         (with-output-stringified
          (parselynn:ll-action:print action)))

       (define result
         (map (lambda (p)
                (define-pair (state conflicts) p)
                (cons state
                      (map
                       (lambda (x)
                         (define-pair (key actions) x)
                         (cons key (map action->string actions)))
                       conflicts)))
              result/raw))

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
    `((S (num "S← num a" "S← num b"))))

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
    `((S (num "S← num a b c" "S← num d e f"))))

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
    `((L (num "L← num" "L← num space L"))
      (R (num "R← num" "R← num space R"))))

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
    `((S (id "S← id op id" "S← id"))))

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
    '((A (a "A← a" "A← a A"))))

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
    `((S (a "S← a B" "S← a C"))))

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
    `((A (a "A← a" "A← a c"))))

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
    `((A (a "A← a B" "A← a C"))))

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
    `((S (x "S← x y" "S← x z" "S← x t"))))

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
    `((A (p "A← p q" "A← p r s"))))

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
    `((A (k "A← k" "A← k m"))
      (B (n "B← n" "B← n o"))))

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
    `((T (a "T← a" "T← a T"))))

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
    `((S (c "S← c d e" "S← c d f"))))

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
    `((S (x "S← M a" "S← M b"))
      (M (x "M← x" "M← x y"))))

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
    `((S (a "S← a b" "S← a c")
         (e "S← e f" "S← e g"))))

  (test-case grammar expected))
