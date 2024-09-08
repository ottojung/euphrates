
;;
;; Define test-case syntax.
;;


(define-syntax test-case
  (syntax-rules ()
    ((_ grammar* expected-text*)
     (let ()
       (define grammar grammar*)
       (define expected-text (string-strip expected-text*))

       (define result
         (parselynn:lr-compute-state-graph grammar))

       (define text
         (string-strip
          (with-output-stringified
           (parselynn:lr-state-graph:print
            result))))

       (unless (equal? text expected-text)
         (debug "correct:\n~a\n\n\n" text))

       (assert= text expected-text)))))


;; ;;;;;;;;;;;;;;;;;
;; ;;
;; ;; Test cases:
;; ;;


;; (let ()
;;   ;;
;;   ;; Simple grammar with single production.
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> a
;;   ;;

;;   (define grammar
;;     '((S (a))))

;;   (define expected-graph
;;     "
;; 0 = { [S → • a, $] }
;;     S -> 2
;;     a -> 1
;; 2 = {}
;; 1 = { [S → a •, $] }
;; ")

;;   (test-case grammar expected-graph))


;; (let ()
;;   ;;
;;   ;; Simple grammar with multiple production 1.
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> a
;;   ;; S -> b
;;   ;; S -> c
;;   ;;

;;   (define grammar
;;     '((S (a) (b) (c))))

;;   (define expected-graph
;;     "
;; 0 = { [S → • a, $] [S → • b, $] [S → • c, $] }
;;     S -> 4
;;     a -> 1
;;     b -> 2
;;     c -> 3
;; 4 = {}
;; 1 = { [S → a •, $] }
;; 2 = { [S → b •, $] }
;; 3 = { [S → c •, $] }
;; ")

;;   (test-case grammar expected-graph))


;; (let ()
;;   ;;
;;   ;; Simple grammar with multiple production 2.
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> a x1
;;   ;; S -> b
;;   ;; S -> c x3
;;   ;;

;;   (define grammar
;;     '((S (a x1) (b) (c x3))))

;;   (define expected-graph
;;     "
;; 0 = { [S → • a x1, $] [S → • b, $] [S → • c x3, $] }
;;     S -> 6
;;     a -> 1
;;     b -> 2
;;     c -> 3
;; 6 = {}
;; 1 = { [S → a • x1, $] }
;;     x1 -> 5
;; 5 = { [S → a x1 •, $] }
;; 2 = { [S → b •, $] }
;; 3 = { [S → c • x3, $] }
;;     x3 -> 4
;; 4 = { [S → c x3 •, $] }
;; ")

;;   (test-case grammar expected-graph))


;; (let ()
;;   ;;
;;   ;; Simple grammar with empty production.
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> a x1
;;   ;; S -> ε
;;   ;; S -> c x3
;;   ;;

;;   (define grammar
;;     '((S (a x1) () (c x3))))

;;   (define expected-graph
;;     "
;; 0 = { [S → • a x1, $] [S → • c x3, $] [S → •, $] }
;;     S -> 5
;;     a -> 1
;;     c -> 2
;; 5 = {}
;; 1 = { [S → a • x1, $] }
;;     x1 -> 4
;; 4 = { [S → a x1 •, $] }
;; 2 = { [S → c • x3, $] }
;;     x3 -> 3
;; 3 = { [S → c x3 •, $] }
;; ")

;;   (test-case grammar expected-graph))


;; (let ()
;;   ;;
;;   ;; Grammar with nested non-terminals.
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> A B
;;   ;; A -> a
;;   ;; B -> b
;;   ;;

;;   (define grammar
;;     '((S (A B))
;;       (A (a))
;;       (B (b))))

;;   (define expected-graph
;;     "
;; 0 = { [A → • a, b] [S → • A B, $] }
;;     A -> 1
;;     S -> 5
;;     a -> 2
;; 1 = { [B → • b, $] [S → A • B, $] }
;;     B -> 3
;;     b -> 4
;; 3 = { [S → A B •, $] }
;; 4 = { [B → b •, $] }
;; 5 = {}
;; 2 = { [A → a •, b] }
;; ")

;;   (test-case grammar expected-graph))


;; (let ()
;;   ;;
;;   ;; Grammar with repeated non-terminals and lookaheads.
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> A A
;;   ;; A -> a
;;   ;;

;;   (define grammar
;;     '((S (A A))
;;       (A (a))))

;;   (define expected-graph
;;     "
;; 0 = { [A → • a, a] [S → • A A, $] }
;;     A -> 1
;;     S -> 5
;;     a -> 2
;; 1 = { [A → • a, $] [S → A • A, $] }
;;     A -> 3
;;     a -> 4
;; 3 = { [S → A A •, $] }
;; 4 = { [A → a •, $] }
;; 5 = {}
;; 2 = { [A → a •, a] }
;; ")

;;   (test-case grammar expected-graph))


;; (let ()
;;   ;;
;;   ;; Empty grammar.
;;   ;;
;;   ;;   Grammar:
;;   ;;

;;   (define grammar
;;     '())

;;   (define expected-graph
;;     "
;; 0 = {}
;; ")

;;   (test-case grammar expected-graph))


;; (let ()
;;   ;;
;;   ;; Minimal grammar with empty production.
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> ε
;;   ;;

;;   (define grammar
;;     '((S ())))

;;   (define expected-graph
;;     "
;; 0 = { [S → •, $] }
;;     S -> 1
;; 1 = {}
;; ")

;;   (test-case grammar expected-graph))


;; (let ()
;;   ;;
;;   ;; Self referential grammar.
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> S
;;   ;;

;;   (define grammar
;;     '((S (S))))

;;   (define expected-graph
;;     "
;; 0 = { [S → • S, $] }
;;     S -> 1
;; 1 = { [S → S •, $] }
;; ")

;;   (test-case grammar expected-graph))


;; (let ()
;;   ;;
;;   ;; Self referential grammar [2].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> S
;;   ;; S -> x
;;   ;;

;;   (define grammar
;;     '((S (S) (x))))

;;   (define expected-graph
;;     "
;; 0 = { [S → • S, $] [S → • x, $] }
;;     S -> 1
;;     x -> 2
;; 1 = { [S → S •, $] }
;; 2 = { [S → x •, $] }
;; ")

;;   (test-case grammar expected-graph))


;; (let ()
;;   ;;
;;   ;; Self referential grammar [3].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> S
;;   ;; S -> x S
;;   ;;

;;   (define grammar
;;     '((S (S) (x S))))

;;   (define expected-graph
;;     "
;; 0 = { [S → • S, $] [S → • x S, $] }
;;     S -> 1
;;     x -> 2
;; 1 = { [S → S •, $] }
;; 2 = { [S → x • S, $] [S → • S, $] [S → • x S, $] }
;;     S -> 3
;;     x -> 2
;; 3 = { [S → S •, $] [S → x S •, $] }
;; ")

;;   (test-case grammar expected-graph))


;; (let ()
;;   ;;
;;   ;; Start issue grammar [1].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> a
;;   ;; S -> b
;;   ;;

;;   (define grammar
;;     '((S (a) (b))))

;;   (define expected-graph
;;     "
;; 0 = { [S → • a, $] [S → • b, $] }
;;     S -> 3
;;     a -> 1
;;     b -> 2
;; 3 = {}
;; 1 = { [S → a •, $] }
;; 2 = { [S → b •, $] }
;; ")

;;   (test-case grammar expected-graph))


;; (let ()
;;   ;;
;;   ;; Start issue grammar [2].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> a
;;   ;; S -> S b
;;   ;;

;;   (define grammar
;;     '((S (a) (S b))))

;;   (define expected-graph
;;     "
;; 0 = { [S → • S b, $] [S → • S b, b] [S → • a, $] [S → • a, b] }
;;     S -> 1
;;     a -> 2
;; 1 = { [S → S • b, $] [S → S • b, b] }
;;     b -> 3
;; 3 = { [S → S b •, $] [S → S b •, b] }
;; 2 = { [S → a •, $] [S → a •, b] }
;; ")

;;   (test-case grammar expected-graph))


;; (let ()
;;   ;;
;;   ;; Start issue grammar [3].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> a
;;   ;; S -> b S
;;   ;;

;;   (define grammar
;;     '((S (a) (b S))))

;;   (define expected-graph
;;     "
;; 0 = { [S → • a, $] [S → • b S, $] }
;;     S -> 4
;;     a -> 1
;;     b -> 2
;; 4 = {}
;; 1 = { [S → a •, $] }
;; 2 = { [S → b • S, $] [S → • a, $] [S → • b S, $] }
;;     S -> 3
;;     a -> 1
;;     b -> 2
;; 3 = { [S → b S •, $] }
;; ")

;;   (test-case grammar expected-graph))


;; (let ()
;;   ;;
;;   ;; Start issue grammar [4].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; O -> S
;;   ;; S -> a
;;   ;; S -> b
;;   ;;

;;   (define grammar
;;     '((O (S)) (S (a) (b))))

;;   (define expected-graph
;;     "
;; 0 = { [O → • S, $] [S → • a, $] [S → • b, $] }
;;     O -> 4
;;     S -> 1
;;     a -> 2
;;     b -> 3
;; 4 = {}
;; 1 = { [O → S •, $] }
;; 2 = { [S → a •, $] }
;; 3 = { [S → b •, $] }
;; ")

;;   (test-case grammar expected-graph))


;; (let ()
;;   ;;
;;   ;; Start issue grammar [5].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; O -> S
;;   ;; S -> a
;;   ;; S -> S b
;;   ;;

;;   (define grammar
;;     '((O (S)) (S (a) (S b))))

;;   (define expected-graph
;;     "
;; 0 = { [O → • S, $] [S → • S b, $] [S → • S b, b] [S → • a, $] [S → • a, b] }
;;     O -> 4
;;     S -> 1
;;     a -> 2
;; 4 = {}
;; 1 = { [O → S •, $] [S → S • b, $] [S → S • b, b] }
;;     b -> 3
;; 3 = { [S → S b •, $] [S → S b •, b] }
;; 2 = { [S → a •, $] [S → a •, b] }
;; ")

;;   (test-case grammar expected-graph))


;; (let ()
;;   ;;
;;   ;; Start issue grammar [6].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; O -> S
;;   ;; S -> a
;;   ;; S -> b S
;;   ;;

;;   (define grammar
;;     '((O (S)) (S (a) (b S))))

;;   (define expected-graph
;;     "
;; 0 = { [O → • S, $] [S → • a, $] [S → • b S, $] }
;;     O -> 5
;;     S -> 1
;;     a -> 2
;;     b -> 3
;; 5 = {}
;; 1 = { [O → S •, $] }
;; 2 = { [S → a •, $] }
;; 3 = { [S → b • S, $] [S → • a, $] [S → • b S, $] }
;;     S -> 4
;;     a -> 2
;;     b -> 3
;; 4 = { [S → b S •, $] }
;; ")

;;   (test-case grammar expected-graph))


;; (let ()
;;   ;;
;;   ;; Umich grammar (https://web.eecs.umich.edu/~weimerw/2009-4610/lectures/weimer-4610-09.pdf page 5).
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; E -> int
;;   ;; E -> E + ( E )
;;   ;;

;;   (define lb
;;     (string->symbol "("))

;;   (define rb
;;     (string->symbol ")"))

;;   (define grammar
;;     `((E (int)
;;          (E + ,lb E ,rb))))

;;   (define expected-graph
;;     "
;; 0 = { [E → • E + ( E ), $] [E → • E + ( E ), +] [E → • int, $] [E → • int, +] }
;;     E -> 1
;;     int -> 2
;; 1 = { [E → E • + ( E ), $] [E → E • + ( E ), +] }
;;     + -> 3
;; 3 = { [E → E + • ( E ), $] [E → E + • ( E ), +] }
;;     ( -> 4
;; 4 = { [E → E + ( • E ), $] [E → E + ( • E ), +] [E → • E + ( E ), )] [E → • E + ( E ), +] [E → • int, )] [E → • int, +] }
;;     E -> 5
;;     int -> 6
;; 5 = { [E → E + ( E • ), $] [E → E + ( E • ), +] [E → E • + ( E ), )] [E → E • + ( E ), +] }
;;     ) -> 7
;;     + -> 8
;; 7 = { [E → E + ( E ) •, $] [E → E + ( E ) •, +] }
;; 8 = { [E → E + • ( E ), )] [E → E + • ( E ), +] }
;;     ( -> 9
;; 9 = { [E → E + ( • E ), )] [E → E + ( • E ), +] [E → • E + ( E ), )] [E → • E + ( E ), +] [E → • int, )] [E → • int, +] }
;;     E -> 10
;;     int -> 6
;; 10 = { [E → E + ( E • ), )] [E → E + ( E • ), +] [E → E • + ( E ), )] [E → E • + ( E ), +] }
;;     ) -> 11
;;     + -> 8
;; 11 = { [E → E + ( E ) •, )] [E → E + ( E ) •, +] }
;; 6 = { [E → int •, )] [E → int •, +] }
;; 2 = { [E → int •, $] [E → int •, +] }
;; ")

;;   (test-case grammar expected-graph))


;; (let ()
;;   ;;
;;   ;; Clemson grammar (https://www.cs.clemson.edu/course/cpsc827/material/LRk/LR1.pdf page 3).
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; G -> S
;;   ;; S -> E = E
;;   ;;    | f
;;   ;; E -> T
;;   ;;    | E + T
;;   ;; T -> f
;;   ;;    | T * f
;;   ;;

;;   (define grammar
;;     `((G (S))
;;       (S (E = E)
;;          (f))
;;       (E (T)
;;          (E + T))
;;       (T (f)
;;          (T * f))))

;;   (define expected-graph
;;     "
;; 0 = { [E → • E + T, +] [E → • E + T, =] [E → • T, +] [E → • T, =] [G → • S, $] [S → • E = E, $] [S → • f, $] [T → • T * f, *] [T → • T * f, +] [T → • T * f, =] [T → • f, *] [T → • f, +] [T → • f, =] }
;;     E -> 1
;;     G -> 18
;;     S -> 2
;;     T -> 3
;;     f -> 4
;; 1 = { [E → E • + T, +] [E → E • + T, =] [S → E • = E, $] }
;;     + -> 7
;;     = -> 8
;; 7 = { [E → E + • T, +] [E → E + • T, =] [T → • T * f, *] [T → • T * f, +] [T → • T * f, =] [T → • f, *] [T → • f, +] [T → • f, =] }
;;     T -> 16
;;     f -> 17
;; 16 = { [E → E + T •, +] [E → E + T •, =] [T → T • * f, *] [T → T • * f, +] [T → T • * f, =] }
;;     * -> 5
;; 5 = { [T → T * • f, *] [T → T * • f, +] [T → T * • f, =] }
;;     f -> 6
;; 6 = { [T → T * f •, *] [T → T * f •, +] [T → T * f •, =] }
;; 17 = { [T → f •, *] [T → f •, +] [T → f •, =] }
;; 8 = { [E → • E + T, $] [E → • E + T, +] [E → • T, $] [E → • T, +] [S → E = • E, $] [T → • T * f, $] [T → • T * f, *] [T → • T * f, +] [T → • f, $] [T → • f, *] [T → • f, +] }
;;     E -> 9
;;     T -> 10
;;     f -> 11
;; 9 = { [E → E • + T, $] [E → E • + T, +] [S → E = E •, $] }
;;     + -> 14
;; 14 = { [E → E + • T, $] [E → E + • T, +] [T → • T * f, $] [T → • T * f, *] [T → • T * f, +] [T → • f, $] [T → • f, *] [T → • f, +] }
;;     T -> 15
;;     f -> 11
;; 15 = { [E → E + T •, $] [E → E + T •, +] [T → T • * f, $] [T → T • * f, *] [T → T • * f, +] }
;;     * -> 12
;; 12 = { [T → T * • f, $] [T → T * • f, *] [T → T * • f, +] }
;;     f -> 13
;; 13 = { [T → T * f •, $] [T → T * f •, *] [T → T * f •, +] }
;; 11 = { [T → f •, $] [T → f •, *] [T → f •, +] }
;; 10 = { [E → T •, $] [E → T •, +] [T → T • * f, $] [T → T • * f, *] [T → T • * f, +] }
;;     * -> 12
;; 18 = {}
;; 2 = { [G → S •, $] }
;; 3 = { [E → T •, +] [E → T •, =] [T → T • * f, *] [T → T • * f, +] [T → T • * f, =] }
;;     * -> 5
;; 4 = { [S → f •, $] [T → f •, *] [T → f •, +] [T → f •, =] }
;; ")

;;   (test-case grammar expected-graph))


;; (let ()
;;   ;;
;;   ;; Wikipedia grammar (https://en.wikipedia.org/wiki/Canonical_LR_parser).
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S → E
;;   ;; E → T
;;   ;; E → ( E )
;;   ;; T → n
;;   ;; T → + T
;;   ;; T → T + n
;;   ;;

;;   (define lb
;;     (string->symbol "("))

;;   (define rb
;;     (string->symbol ")"))

;;   (define grammar
;;     `((S (E))
;;       (E (T) (,lb E ,rb))
;;       (T (n) (+ T) (T + n))))

;;   (define expected-graph
;;     "
;; 0 = { [E → • ( E ), $] [E → • T, $] [S → • E, $] [T → • + T, $] [T → • + T, +] [T → • T + n, $] [T → • T + n, +] [T → • n, $] [T → • n, +] }
;;     ( -> 1
;;     + -> 2
;;     E -> 3
;;     S -> 20
;;     T -> 4
;;     n -> 5
;; 1 = { [E → ( • E ), $] [E → • ( E ), )] [E → • T, )] [T → • + T, )] [T → • + T, +] [T → • T + n, )] [T → • T + n, +] [T → • n, )] [T → • n, +] }
;;     ( -> 9
;;     + -> 10
;;     E -> 11
;;     T -> 12
;;     n -> 13
;; 9 = { [E → ( • E ), )] [E → • ( E ), )] [E → • T, )] [T → • + T, )] [T → • + T, +] [T → • T + n, )] [T → • T + n, +] [T → • n, )] [T → • n, +] }
;;     ( -> 9
;;     + -> 10
;;     E -> 18
;;     T -> 12
;;     n -> 13
;; 10 = { [T → + • T, )] [T → + • T, +] [T → • + T, )] [T → • + T, +] [T → • T + n, )] [T → • T + n, +] [T → • n, )] [T → • n, +] }
;;     + -> 10
;;     T -> 17
;;     n -> 13
;; 17 = { [T → + T •, )] [T → + T •, +] [T → T • + n, )] [T → T • + n, +] }
;;     + -> 14
;; 14 = { [T → T + • n, )] [T → T + • n, +] }
;;     n -> 15
;; 15 = { [T → T + n •, )] [T → T + n •, +] }
;; 13 = { [T → n •, )] [T → n •, +] }
;; 18 = { [E → ( E • ), )] }
;;     ) -> 19
;; 19 = { [E → ( E ) •, )] }
;; 12 = { [E → T •, )] [T → T • + n, )] [T → T • + n, +] }
;;     + -> 14
;; 11 = { [E → ( E • ), $] }
;;     ) -> 16
;; 16 = { [E → ( E ) •, $] }
;; 2 = { [T → + • T, $] [T → + • T, +] [T → • + T, $] [T → • + T, +] [T → • T + n, $] [T → • T + n, +] [T → • n, $] [T → • n, +] }
;;     + -> 2
;;     T -> 8
;;     n -> 5
;; 8 = { [T → + T •, $] [T → + T •, +] [T → T • + n, $] [T → T • + n, +] }
;;     + -> 6
;; 6 = { [T → T + • n, $] [T → T + • n, +] }
;;     n -> 7
;; 7 = { [T → T + n •, $] [T → T + n •, +] }
;; 5 = { [T → n •, $] [T → n •, +] }
;; 3 = { [S → E •, $] }
;; 20 = {}
;; 4 = { [E → T •, $] [T → T • + n, $] [T → T • + n, +] }
;;     + -> 6
;; ")

;;   (test-case grammar expected-graph))


;; (let ()
;;   ;;
;;   ;; Youtube grammar. (https://invidious.reallyaweso.me/watch?v=sh_X56otRdU)
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> X X
;;   ;; X -> a X
;;   ;; X -> b
;;   ;;
;;   ;;   Notes:
;;   ;;
;;   ;; Compared to the reference graph:
;;   ;; - Our items have single symbols as lookaheads
;;   ;;   whereas the reference uses sets of symbols.
;;   ;;   Ex. we have both ", a" and ", b" instead of ", a/b".
;;   ;; - We have a different state 0.
;;   ;;   This is because we do not create an additional S' nonterminal.
;;   ;; - Correspondence between states is the following:
;;   ;;
;;   ;;       / Reference state # / Our state # /
;;   ;;       / ----------------- / ----------- /
;;   ;;       /         0         /      0      /
;;   ;;       /         1         /      9      /
;;   ;;       /         2         /      1      /
;;   ;;       /         3         /      3      /
;;   ;;       /         4         /      2      /
;;   ;;       /         5         /      5      /
;;   ;;       /         6         /      6      /
;;   ;;       /         7         /      7      /
;;   ;;       /         8         /      8      /
;;   ;;       /         9         /      4      /
;;   ;;       / ----------------- / ----------- /
;;   ;;
;;   ;;

;;   (define grammar
;;     '((S (X X))
;;       (X (a X)
;;          (b))))

;;   (define expected-graph
;;     "
;; 0 = { [S → • X X, $] [X → • a X, a] [X → • a X, b] [X → • b, a] [X → • b, b] }
;;     S -> 9
;;     X -> 1
;;     a -> 2
;;     b -> 3
;; 9 = {}
;; 1 = { [S → X • X, $] [X → • a X, $] [X → • b, $] }
;;     X -> 5
;;     a -> 6
;;     b -> 7
;; 5 = { [S → X X •, $] }
;; 6 = { [X → a • X, $] [X → • a X, $] [X → • b, $] }
;;     X -> 8
;;     a -> 6
;;     b -> 7
;; 8 = { [X → a X •, $] }
;; 7 = { [X → b •, $] }
;; 2 = { [X → a • X, a] [X → a • X, b] [X → • a X, a] [X → • a X, b] [X → • b, a] [X → • b, b] }
;;     X -> 4
;;     a -> 2
;;     b -> 3
;; 4 = { [X → a X •, a] [X → a X •, b] }
;; 3 = { [X → b •, a] [X → b •, b] }
;; ")

;;   (test-case grammar expected-graph))


;; (let ()
;;   ;;
;;   ;; Misleading epsilon grammar.
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; E -> E A T | T.
;;   ;; A -> S + S.
;;   ;; T -> S T S | e T r | n.
;;   ;; S -> p S | .
;;   ;;

;;   (define grammar
;;     `((E (E A T) (T))
;;       (A (S + S))
;;       (T (S T S)
;;          (e T r)
;;          (n))
;;       (S (p S) ())))

;;   (define expected-graph
;;     "
;; 0 = { [E → • E A T, $] [E → • E A T, +] [E → • E A T, p] [E → • T, $] [E → • T, +] [E → • T, p] [S → • p S, e] [S → • p S, n] [S → • p S, p] [S → •, e] [S → •, n] [S → •, p] [T → • S T S, $] [T → • S T S, +] [T → • S T S, p] [T → • e T r, $] [T → • e T r, +] [T → • e T r, p] [T → • n, $] [T → • n, +] [T → • n, p] }
;;     E -> 1
;;     S -> 2
;;     T -> 3
;;     e -> 4
;;     n -> 5
;;     p -> 6
;; 1 = { [A → • S + S, e] [A → • S + S, n] [A → • S + S, p] [E → E • A T, $] [E → E • A T, +] [E → E • A T, p] [S → • p S, +] [S → •, +] }
;;     A -> 32
;;     S -> 33
;;     p -> 34
;; 32 = { [E → E A • T, $] [E → E A • T, +] [E → E A • T, p] [S → • p S, e] [S → • p S, n] [S → • p S, p] [S → •, e] [S → •, n] [S → •, p] [T → • S T S, $] [T → • S T S, +] [T → • S T S, p] [T → • e T r, $] [T → • e T r, +] [T → • e T r, p] [T → • n, $] [T → • n, +] [T → • n, p] }
;;     S -> 2
;;     T -> 38
;;     e -> 4
;;     n -> 5
;;     p -> 6
;; 2 = { [S → • p S, e] [S → • p S, n] [S → • p S, p] [S → •, e] [S → •, n] [S → •, p] [T → S • T S, $] [T → S • T S, +] [T → S • T S, p] [T → • S T S, $] [T → • S T S, +] [T → • S T S, p] [T → • e T r, $] [T → • e T r, +] [T → • e T r, p] [T → • n, $] [T → • n, +] [T → • n, p] }
;;     S -> 2
;;     T -> 28
;;     e -> 4
;;     n -> 5
;;     p -> 6
;; 28 = { [S → • p S, $] [S → • p S, +] [S → • p S, p] [S → •, $] [S → •, +] [S → •, p] [T → S T • S, $] [T → S T • S, +] [T → S T • S, p] }
;;     S -> 29
;;     p -> 30
;; 29 = { [T → S T S •, $] [T → S T S •, +] [T → S T S •, p] }
;; 30 = { [S → p • S, $] [S → p • S, +] [S → p • S, p] [S → • p S, $] [S → • p S, +] [S → • p S, p] [S → •, $] [S → •, +] [S → •, p] }
;;     S -> 31
;;     p -> 30
;; 31 = { [S → p S •, $] [S → p S •, +] [S → p S •, p] }
;; 4 = { [S → • p S, e] [S → • p S, n] [S → • p S, p] [S → •, e] [S → •, n] [S → •, p] [T → e • T r, $] [T → e • T r, +] [T → e • T r, p] [T → • S T S, r] [T → • e T r, r] [T → • n, r] }
;;     S -> 8
;;     T -> 9
;;     e -> 10
;;     n -> 11
;;     p -> 6
;; 8 = { [S → • p S, e] [S → • p S, n] [S → • p S, p] [S → •, e] [S → •, n] [S → •, p] [T → S • T S, r] [T → • S T S, p] [T → • S T S, r] [T → • e T r, p] [T → • e T r, r] [T → • n, p] [T → • n, r] }
;;     S -> 15
;;     T -> 16
;;     e -> 17
;;     n -> 18
;;     p -> 6
;; 15 = { [S → • p S, e] [S → • p S, n] [S → • p S, p] [S → •, e] [S → •, n] [S → •, p] [T → S • T S, p] [T → S • T S, r] [T → • S T S, p] [T → • S T S, r] [T → • e T r, p] [T → • e T r, r] [T → • n, p] [T → • n, r] }
;;     S -> 15
;;     T -> 24
;;     e -> 17
;;     n -> 18
;;     p -> 6
;; 24 = { [S → • p S, p] [S → • p S, r] [S → •, p] [S → •, r] [T → S T • S, p] [T → S T • S, r] }
;;     S -> 25
;;     p -> 26
;; 25 = { [T → S T S •, p] [T → S T S •, r] }
;; 26 = { [S → p • S, p] [S → p • S, r] [S → • p S, p] [S → • p S, r] [S → •, p] [S → •, r] }
;;     S -> 27
;;     p -> 26
;; 27 = { [S → p S •, p] [S → p S •, r] }
;; 17 = { [S → • p S, e] [S → • p S, n] [S → • p S, p] [S → •, e] [S → •, n] [S → •, p] [T → e • T r, p] [T → e • T r, r] [T → • S T S, r] [T → • e T r, r] [T → • n, r] }
;;     S -> 8
;;     T -> 19
;;     e -> 10
;;     n -> 11
;;     p -> 6
;; 19 = { [T → e T • r, p] [T → e T • r, r] }
;;     r -> 20
;; 20 = { [T → e T r •, p] [T → e T r •, r] }
;; 10 = { [S → • p S, e] [S → • p S, n] [S → • p S, p] [S → •, e] [S → •, n] [S → •, p] [T → e • T r, r] [T → • S T S, r] [T → • e T r, r] [T → • n, r] }
;;     S -> 8
;;     T -> 12
;;     e -> 10
;;     n -> 11
;;     p -> 6
;; 12 = { [T → e T • r, r] }
;;     r -> 13
;; 13 = { [T → e T r •, r] }
;; 11 = { [T → n •, r] }
;; 6 = { [S → p • S, e] [S → p • S, n] [S → p • S, p] [S → • p S, e] [S → • p S, n] [S → • p S, p] [S → •, e] [S → •, n] [S → •, p] }
;;     S -> 7
;;     p -> 6
;; 7 = { [S → p S •, e] [S → p S •, n] [S → p S •, p] }
;; 18 = { [T → n •, p] [T → n •, r] }
;; 16 = { [S → • p S, r] [S → •, r] [T → S T • S, r] }
;;     S -> 21
;;     p -> 22
;; 21 = { [T → S T S •, r] }
;; 22 = { [S → p • S, r] [S → • p S, r] [S → •, r] }
;;     S -> 23
;;     p -> 22
;; 23 = { [S → p S •, r] }
;; 9 = { [T → e T • r, $] [T → e T • r, +] [T → e T • r, p] }
;;     r -> 14
;; 14 = { [T → e T r •, $] [T → e T r •, +] [T → e T r •, p] }
;; 5 = { [T → n •, $] [T → n •, +] [T → n •, p] }
;; 38 = { [E → E A T •, $] [E → E A T •, +] [E → E A T •, p] }
;; 33 = { [A → S • + S, e] [A → S • + S, n] [A → S • + S, p] }
;;     + -> 36
;; 36 = { [A → S + • S, e] [A → S + • S, n] [A → S + • S, p] [S → • p S, e] [S → • p S, n] [S → • p S, p] [S → •, e] [S → •, n] [S → •, p] }
;;     S -> 37
;;     p -> 6
;; 37 = { [A → S + S •, e] [A → S + S •, n] [A → S + S •, p] }
;; 34 = { [S → p • S, +] [S → • p S, +] [S → •, +] }
;;     S -> 35
;;     p -> 34
;; 35 = { [S → p S •, +] }
;; 3 = { [E → T •, $] [E → T •, +] [E → T •, p] }
;; ")

;;   (test-case grammar expected-graph))

(let ()
  ;;
  ;; A large grammar.
  ;;
  ;;   Grammar:
  ;;
  ;;  ((expr (term add expr) (term))
  ;;   (add (uid_1))
  ;;   (term (num))
  ;;   (num (dig num) (dig))
  ;;   (dig (uid_2)
  ;;        (uid_3)
  ;;        (uid_4)
  ;;        (uid_5)
  ;;        (uid_6)
  ;;        (uid_7)
  ;;        (uid_8)
  ;;        (uid_9)
  ;;        (uid_10)
  ;;        (uid_11)))
  ;;
  ;;   Notes:
  ;;
  ;; This sometimes produced different parsing tables, nondeterministically.
  ;;

  (define grammar
    `((expr (term add expr) (term))
      (add (uid_1))
      (term (num))
      (num (dig num) (dig))
      (dig (uid_2)
           (uid_3)
           (uid_4)
           (uid_5)
           (uid_6)
           (uid_7)
           (uid_8)
           (uid_9)
           (uid_10)
           (uid_11))))

  (define expected-graph
    "
0 = { [dig → • uid_10, $] [dig → • uid_10, uid_10] [dig → • uid_10, uid_11] [dig → • uid_10, uid_1] [dig → • uid_10, uid_2] [dig → • uid_10, uid_3] [dig → • uid_10, uid_4] [dig → • uid_10, uid_5] [dig → • uid_10, uid_6] [dig → • uid_10, uid_7] [dig → • uid_10, uid_8] [dig → • uid_10, uid_9] [dig → • uid_11, $] [dig → • uid_11, uid_10] [dig → • uid_11, uid_11] [dig → • uid_11, uid_1] [dig → • uid_11, uid_2] [dig → • uid_11, uid_3] [dig → • uid_11, uid_4] [dig → • uid_11, uid_5] [dig → • uid_11, uid_6] [dig → • uid_11, uid_7] [dig → • uid_11, uid_8] [dig → • uid_11, uid_9] [dig → • uid_2, $] [dig → • uid_2, uid_10] [dig → • uid_2, uid_11] [dig → • uid_2, uid_1] [dig → • uid_2, uid_2] [dig → • uid_2, uid_3] [dig → • uid_2, uid_4] [dig → • uid_2, uid_5] [dig → • uid_2, uid_6] [dig → • uid_2, uid_7] [dig → • uid_2, uid_8] [dig → • uid_2, uid_9] [dig → • uid_3, $] [dig → • uid_3, uid_10] [dig → • uid_3, uid_11] [dig → • uid_3, uid_1] [dig → • uid_3, uid_2] [dig → • uid_3, uid_3] [dig → • uid_3, uid_4] [dig → • uid_3, uid_5] [dig → • uid_3, uid_6] [dig → • uid_3, uid_7] [dig → • uid_3, uid_8] [dig → • uid_3, uid_9] [dig → • uid_4, $] [dig → • uid_4, uid_10] [dig → • uid_4, uid_11] [dig → • uid_4, uid_1] [dig → • uid_4, uid_2] [dig → • uid_4, uid_3] [dig → • uid_4, uid_4] [dig → • uid_4, uid_5] [dig → • uid_4, uid_6] [dig → • uid_4, uid_7] [dig → • uid_4, uid_8] [dig → • uid_4, uid_9] [dig → • uid_5, $] [dig → • uid_5, uid_10] [dig → • uid_5, uid_11] [dig → • uid_5, uid_1] [dig → • uid_5, uid_2] [dig → • uid_5, uid_3] [dig → • uid_5, uid_4] [dig → • uid_5, uid_5] [dig → • uid_5, uid_6] [dig → • uid_5, uid_7] [dig → • uid_5, uid_8] [dig → • uid_5, uid_9] [dig → • uid_6, $] [dig → • uid_6, uid_10] [dig → • uid_6, uid_11] [dig → • uid_6, uid_1] [dig → • uid_6, uid_2] [dig → • uid_6, uid_3] [dig → • uid_6, uid_4] [dig → • uid_6, uid_5] [dig → • uid_6, uid_6] [dig → • uid_6, uid_7] [dig → • uid_6, uid_8] [dig → • uid_6, uid_9] [dig → • uid_7, $] [dig → • uid_7, uid_10] [dig → • uid_7, uid_11] [dig → • uid_7, uid_1] [dig → • uid_7, uid_2] [dig → • uid_7, uid_3] [dig → • uid_7, uid_4] [dig → • uid_7, uid_5] [dig → • uid_7, uid_6] [dig → • uid_7, uid_7] [dig → • uid_7, uid_8] [dig → • uid_7, uid_9] [dig → • uid_8, $] [dig → • uid_8, uid_10] [dig → • uid_8, uid_11] [dig → • uid_8, uid_1] [dig → • uid_8, uid_2] [dig → • uid_8, uid_3] [dig → • uid_8, uid_4] [dig → • uid_8, uid_5] [dig → • uid_8, uid_6] [dig → • uid_8, uid_7] [dig → • uid_8, uid_8] [dig → • uid_8, uid_9] [dig → • uid_9, $] [dig → • uid_9, uid_10] [dig → • uid_9, uid_11] [dig → • uid_9, uid_1] [dig → • uid_9, uid_2] [dig → • uid_9, uid_3] [dig → • uid_9, uid_4] [dig → • uid_9, uid_5] [dig → • uid_9, uid_6] [dig → • uid_9, uid_7] [dig → • uid_9, uid_8] [dig → • uid_9, uid_9] [expr → • term add expr, $] [expr → • term, $] [num → • dig num, $] [num → • dig num, uid_1] [num → • dig, $] [num → • dig, uid_1] [term → • num, $] [term → • num, uid_1] }
    dig -> 1
    expr -> 18
    num -> 2
    term -> 3
    uid_10 -> 4
    uid_11 -> 5
    uid_2 -> 6
    uid_3 -> 7
    uid_4 -> 8
    uid_5 -> 9
    uid_6 -> 10
    uid_7 -> 11
    uid_8 -> 12
    uid_9 -> 13
1 = { [dig → • uid_10, $] [dig → • uid_10, uid_10] [dig → • uid_10, uid_11] [dig → • uid_10, uid_1] [dig → • uid_10, uid_2] [dig → • uid_10, uid_3] [dig → • uid_10, uid_4] [dig → • uid_10, uid_5] [dig → • uid_10, uid_6] [dig → • uid_10, uid_7] [dig → • uid_10, uid_8] [dig → • uid_10, uid_9] [dig → • uid_11, $] [dig → • uid_11, uid_10] [dig → • uid_11, uid_11] [dig → • uid_11, uid_1] [dig → • uid_11, uid_2] [dig → • uid_11, uid_3] [dig → • uid_11, uid_4] [dig → • uid_11, uid_5] [dig → • uid_11, uid_6] [dig → • uid_11, uid_7] [dig → • uid_11, uid_8] [dig → • uid_11, uid_9] [dig → • uid_2, $] [dig → • uid_2, uid_10] [dig → • uid_2, uid_11] [dig → • uid_2, uid_1] [dig → • uid_2, uid_2] [dig → • uid_2, uid_3] [dig → • uid_2, uid_4] [dig → • uid_2, uid_5] [dig → • uid_2, uid_6] [dig → • uid_2, uid_7] [dig → • uid_2, uid_8] [dig → • uid_2, uid_9] [dig → • uid_3, $] [dig → • uid_3, uid_10] [dig → • uid_3, uid_11] [dig → • uid_3, uid_1] [dig → • uid_3, uid_2] [dig → • uid_3, uid_3] [dig → • uid_3, uid_4] [dig → • uid_3, uid_5] [dig → • uid_3, uid_6] [dig → • uid_3, uid_7] [dig → • uid_3, uid_8] [dig → • uid_3, uid_9] [dig → • uid_4, $] [dig → • uid_4, uid_10] [dig → • uid_4, uid_11] [dig → • uid_4, uid_1] [dig → • uid_4, uid_2] [dig → • uid_4, uid_3] [dig → • uid_4, uid_4] [dig → • uid_4, uid_5] [dig → • uid_4, uid_6] [dig → • uid_4, uid_7] [dig → • uid_4, uid_8] [dig → • uid_4, uid_9] [dig → • uid_5, $] [dig → • uid_5, uid_10] [dig → • uid_5, uid_11] [dig → • uid_5, uid_1] [dig → • uid_5, uid_2] [dig → • uid_5, uid_3] [dig → • uid_5, uid_4] [dig → • uid_5, uid_5] [dig → • uid_5, uid_6] [dig → • uid_5, uid_7] [dig → • uid_5, uid_8] [dig → • uid_5, uid_9] [dig → • uid_6, $] [dig → • uid_6, uid_10] [dig → • uid_6, uid_11] [dig → • uid_6, uid_1] [dig → • uid_6, uid_2] [dig → • uid_6, uid_3] [dig → • uid_6, uid_4] [dig → • uid_6, uid_5] [dig → • uid_6, uid_6] [dig → • uid_6, uid_7] [dig → • uid_6, uid_8] [dig → • uid_6, uid_9] [dig → • uid_7, $] [dig → • uid_7, uid_10] [dig → • uid_7, uid_11] [dig → • uid_7, uid_1] [dig → • uid_7, uid_2] [dig → • uid_7, uid_3] [dig → • uid_7, uid_4] [dig → • uid_7, uid_5] [dig → • uid_7, uid_6] [dig → • uid_7, uid_7] [dig → • uid_7, uid_8] [dig → • uid_7, uid_9] [dig → • uid_8, $] [dig → • uid_8, uid_10] [dig → • uid_8, uid_11] [dig → • uid_8, uid_1] [dig → • uid_8, uid_2] [dig → • uid_8, uid_3] [dig → • uid_8, uid_4] [dig → • uid_8, uid_5] [dig → • uid_8, uid_6] [dig → • uid_8, uid_7] [dig → • uid_8, uid_8] [dig → • uid_8, uid_9] [dig → • uid_9, $] [dig → • uid_9, uid_10] [dig → • uid_9, uid_11] [dig → • uid_9, uid_1] [dig → • uid_9, uid_2] [dig → • uid_9, uid_3] [dig → • uid_9, uid_4] [dig → • uid_9, uid_5] [dig → • uid_9, uid_6] [dig → • uid_9, uid_7] [dig → • uid_9, uid_8] [dig → • uid_9, uid_9] [num → dig • num, $] [num → dig • num, uid_1] [num → dig •, $] [num → dig •, uid_1] [num → • dig num, $] [num → • dig num, uid_1] [num → • dig, $] [num → • dig, uid_1] }
    dig -> 1
    num -> 17
    uid_10 -> 4
    uid_11 -> 5
    uid_2 -> 6
    uid_3 -> 7
    uid_4 -> 8
    uid_5 -> 9
    uid_6 -> 10
    uid_7 -> 11
    uid_8 -> 12
    uid_9 -> 13
17 = { [num → dig num •, $] [num → dig num •, uid_1] }
4 = { [dig → uid_10 •, $] [dig → uid_10 •, uid_10] [dig → uid_10 •, uid_11] [dig → uid_10 •, uid_1] [dig → uid_10 •, uid_2] [dig → uid_10 •, uid_3] [dig → uid_10 •, uid_4] [dig → uid_10 •, uid_5] [dig → uid_10 •, uid_6] [dig → uid_10 •, uid_7] [dig → uid_10 •, uid_8] [dig → uid_10 •, uid_9] }
5 = { [dig → uid_11 •, $] [dig → uid_11 •, uid_10] [dig → uid_11 •, uid_11] [dig → uid_11 •, uid_1] [dig → uid_11 •, uid_2] [dig → uid_11 •, uid_3] [dig → uid_11 •, uid_4] [dig → uid_11 •, uid_5] [dig → uid_11 •, uid_6] [dig → uid_11 •, uid_7] [dig → uid_11 •, uid_8] [dig → uid_11 •, uid_9] }
6 = { [dig → uid_2 •, $] [dig → uid_2 •, uid_10] [dig → uid_2 •, uid_11] [dig → uid_2 •, uid_1] [dig → uid_2 •, uid_2] [dig → uid_2 •, uid_3] [dig → uid_2 •, uid_4] [dig → uid_2 •, uid_5] [dig → uid_2 •, uid_6] [dig → uid_2 •, uid_7] [dig → uid_2 •, uid_8] [dig → uid_2 •, uid_9] }
7 = { [dig → uid_3 •, $] [dig → uid_3 •, uid_10] [dig → uid_3 •, uid_11] [dig → uid_3 •, uid_1] [dig → uid_3 •, uid_2] [dig → uid_3 •, uid_3] [dig → uid_3 •, uid_4] [dig → uid_3 •, uid_5] [dig → uid_3 •, uid_6] [dig → uid_3 •, uid_7] [dig → uid_3 •, uid_8] [dig → uid_3 •, uid_9] }
8 = { [dig → uid_4 •, $] [dig → uid_4 •, uid_10] [dig → uid_4 •, uid_11] [dig → uid_4 •, uid_1] [dig → uid_4 •, uid_2] [dig → uid_4 •, uid_3] [dig → uid_4 •, uid_4] [dig → uid_4 •, uid_5] [dig → uid_4 •, uid_6] [dig → uid_4 •, uid_7] [dig → uid_4 •, uid_8] [dig → uid_4 •, uid_9] }
9 = { [dig → uid_5 •, $] [dig → uid_5 •, uid_10] [dig → uid_5 •, uid_11] [dig → uid_5 •, uid_1] [dig → uid_5 •, uid_2] [dig → uid_5 •, uid_3] [dig → uid_5 •, uid_4] [dig → uid_5 •, uid_5] [dig → uid_5 •, uid_6] [dig → uid_5 •, uid_7] [dig → uid_5 •, uid_8] [dig → uid_5 •, uid_9] }
10 = { [dig → uid_6 •, $] [dig → uid_6 •, uid_10] [dig → uid_6 •, uid_11] [dig → uid_6 •, uid_1] [dig → uid_6 •, uid_2] [dig → uid_6 •, uid_3] [dig → uid_6 •, uid_4] [dig → uid_6 •, uid_5] [dig → uid_6 •, uid_6] [dig → uid_6 •, uid_7] [dig → uid_6 •, uid_8] [dig → uid_6 •, uid_9] }
11 = { [dig → uid_7 •, $] [dig → uid_7 •, uid_10] [dig → uid_7 •, uid_11] [dig → uid_7 •, uid_1] [dig → uid_7 •, uid_2] [dig → uid_7 •, uid_3] [dig → uid_7 •, uid_4] [dig → uid_7 •, uid_5] [dig → uid_7 •, uid_6] [dig → uid_7 •, uid_7] [dig → uid_7 •, uid_8] [dig → uid_7 •, uid_9] }
12 = { [dig → uid_8 •, $] [dig → uid_8 •, uid_10] [dig → uid_8 •, uid_11] [dig → uid_8 •, uid_1] [dig → uid_8 •, uid_2] [dig → uid_8 •, uid_3] [dig → uid_8 •, uid_4] [dig → uid_8 •, uid_5] [dig → uid_8 •, uid_6] [dig → uid_8 •, uid_7] [dig → uid_8 •, uid_8] [dig → uid_8 •, uid_9] }
13 = { [dig → uid_9 •, $] [dig → uid_9 •, uid_10] [dig → uid_9 •, uid_11] [dig → uid_9 •, uid_1] [dig → uid_9 •, uid_2] [dig → uid_9 •, uid_3] [dig → uid_9 •, uid_4] [dig → uid_9 •, uid_5] [dig → uid_9 •, uid_6] [dig → uid_9 •, uid_7] [dig → uid_9 •, uid_8] [dig → uid_9 •, uid_9] }
18 = {}
2 = { [term → num •, $] [term → num •, uid_1] }
3 = { [add → • uid_1, uid_10] [add → • uid_1, uid_11] [add → • uid_1, uid_2] [add → • uid_1, uid_3] [add → • uid_1, uid_4] [add → • uid_1, uid_5] [add → • uid_1, uid_6] [add → • uid_1, uid_7] [add → • uid_1, uid_8] [add → • uid_1, uid_9] [expr → term • add expr, $] [expr → term •, $] }
    add -> 14
    uid_1 -> 15
14 = { [dig → • uid_10, $] [dig → • uid_10, uid_10] [dig → • uid_10, uid_11] [dig → • uid_10, uid_1] [dig → • uid_10, uid_2] [dig → • uid_10, uid_3] [dig → • uid_10, uid_4] [dig → • uid_10, uid_5] [dig → • uid_10, uid_6] [dig → • uid_10, uid_7] [dig → • uid_10, uid_8] [dig → • uid_10, uid_9] [dig → • uid_11, $] [dig → • uid_11, uid_10] [dig → • uid_11, uid_11] [dig → • uid_11, uid_1] [dig → • uid_11, uid_2] [dig → • uid_11, uid_3] [dig → • uid_11, uid_4] [dig → • uid_11, uid_5] [dig → • uid_11, uid_6] [dig → • uid_11, uid_7] [dig → • uid_11, uid_8] [dig → • uid_11, uid_9] [dig → • uid_2, $] [dig → • uid_2, uid_10] [dig → • uid_2, uid_11] [dig → • uid_2, uid_1] [dig → • uid_2, uid_2] [dig → • uid_2, uid_3] [dig → • uid_2, uid_4] [dig → • uid_2, uid_5] [dig → • uid_2, uid_6] [dig → • uid_2, uid_7] [dig → • uid_2, uid_8] [dig → • uid_2, uid_9] [dig → • uid_3, $] [dig → • uid_3, uid_10] [dig → • uid_3, uid_11] [dig → • uid_3, uid_1] [dig → • uid_3, uid_2] [dig → • uid_3, uid_3] [dig → • uid_3, uid_4] [dig → • uid_3, uid_5] [dig → • uid_3, uid_6] [dig → • uid_3, uid_7] [dig → • uid_3, uid_8] [dig → • uid_3, uid_9] [dig → • uid_4, $] [dig → • uid_4, uid_10] [dig → • uid_4, uid_11] [dig → • uid_4, uid_1] [dig → • uid_4, uid_2] [dig → • uid_4, uid_3] [dig → • uid_4, uid_4] [dig → • uid_4, uid_5] [dig → • uid_4, uid_6] [dig → • uid_4, uid_7] [dig → • uid_4, uid_8] [dig → • uid_4, uid_9] [dig → • uid_5, $] [dig → • uid_5, uid_10] [dig → • uid_5, uid_11] [dig → • uid_5, uid_1] [dig → • uid_5, uid_2] [dig → • uid_5, uid_3] [dig → • uid_5, uid_4] [dig → • uid_5, uid_5] [dig → • uid_5, uid_6] [dig → • uid_5, uid_7] [dig → • uid_5, uid_8] [dig → • uid_5, uid_9] [dig → • uid_6, $] [dig → • uid_6, uid_10] [dig → • uid_6, uid_11] [dig → • uid_6, uid_1] [dig → • uid_6, uid_2] [dig → • uid_6, uid_3] [dig → • uid_6, uid_4] [dig → • uid_6, uid_5] [dig → • uid_6, uid_6] [dig → • uid_6, uid_7] [dig → • uid_6, uid_8] [dig → • uid_6, uid_9] [dig → • uid_7, $] [dig → • uid_7, uid_10] [dig → • uid_7, uid_11] [dig → • uid_7, uid_1] [dig → • uid_7, uid_2] [dig → • uid_7, uid_3] [dig → • uid_7, uid_4] [dig → • uid_7, uid_5] [dig → • uid_7, uid_6] [dig → • uid_7, uid_7] [dig → • uid_7, uid_8] [dig → • uid_7, uid_9] [dig → • uid_8, $] [dig → • uid_8, uid_10] [dig → • uid_8, uid_11] [dig → • uid_8, uid_1] [dig → • uid_8, uid_2] [dig → • uid_8, uid_3] [dig → • uid_8, uid_4] [dig → • uid_8, uid_5] [dig → • uid_8, uid_6] [dig → • uid_8, uid_7] [dig → • uid_8, uid_8] [dig → • uid_8, uid_9] [dig → • uid_9, $] [dig → • uid_9, uid_10] [dig → • uid_9, uid_11] [dig → • uid_9, uid_1] [dig → • uid_9, uid_2] [dig → • uid_9, uid_3] [dig → • uid_9, uid_4] [dig → • uid_9, uid_5] [dig → • uid_9, uid_6] [dig → • uid_9, uid_7] [dig → • uid_9, uid_8] [dig → • uid_9, uid_9] [expr → term add • expr, $] [expr → • term add expr, $] [expr → • term, $] [num → • dig num, $] [num → • dig num, uid_1] [num → • dig, $] [num → • dig, uid_1] [term → • num, $] [term → • num, uid_1] }
    dig -> 1
    expr -> 16
    num -> 2
    term -> 3
    uid_10 -> 4
    uid_11 -> 5
    uid_2 -> 6
    uid_3 -> 7
    uid_4 -> 8
    uid_5 -> 9
    uid_6 -> 10
    uid_7 -> 11
    uid_8 -> 12
    uid_9 -> 13
16 = { [expr → term add expr •, $] }
15 = { [add → uid_1 •, uid_10] [add → uid_1 •, uid_11] [add → uid_1 •, uid_2] [add → uid_1 •, uid_3] [add → uid_1 •, uid_4] [add → uid_1 •, uid_5] [add → uid_1 •, uid_6] [add → uid_1 •, uid_7] [add → uid_1 •, uid_8] [add → uid_1 •, uid_9] }
")

  (test-case grammar expected-graph))
