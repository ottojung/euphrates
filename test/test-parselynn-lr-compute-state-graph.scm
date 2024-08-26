
;;
;; Define test-case syntax.
;;

(define-syntax test-1-case
  (syntax-rules ()
    ((_ grammar* state* expected-text*)
     (let ()
       (define grammar grammar*)
       (define state state*)
       (define expected-text (string-strip expected-text*))
       (define graph (parselynn:lr-state-graph:make state))

       (parselynn:lr-state:collect-outgoing-states
        grammar state graph)

       (define text
         (string-strip
          (with-output-stringified
           (parselynn:lr-state-graph:print
            graph))))

       (unless (equal? text expected-text)
         (debug "\ncorrect:\n~a\n\n" text))

       (assert= text expected-text)))))


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
         (debug "\ncorrect:\n~a\n\n" text))

       (assert= text expected-text)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Test cases for collect outgoing states:
;;


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

  (define expected-graph
    "
0 = { [S → • a, $] }
a -> 1
1 = { [S → a •, $] }
")

  (test-case grammar expected-graph))


(let ()
  ;;
  ;; Simple grammar with multiple production 1.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> a
  ;; S -> b
  ;; S -> c
  ;;

  (define grammar
    '((S (a) (b) (c))))

  (define expected-graph
    "
0 = { [S → • a, $] [S → • b, $] [S → • c, $] }
a -> 1
b -> 2
c -> 3
1 = { [S → a •, $] }
2 = { [S → b •, $] }
3 = { [S → c •, $] }
")

  (test-case grammar expected-graph))


(let ()
  ;;
  ;; Simple grammar with multiple production 2.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> a x1
  ;; S -> b
  ;; S -> c x3
  ;;

  (define grammar
    '((S (a x1) (b) (c x3))))

  (define expected-graph
    "
0 = { [S → • a x1, $] [S → • b, $] [S → • c x3, $] }
a -> 1
b -> 2
c -> 3
1 = { [S → a • x1, $] }
x1 -> 5
5 = { [S → a x1 •, $] }
2 = { [S → b •, $] }
3 = { [S → c • x3, $] }
x3 -> 4
4 = { [S → c x3 •, $] }
")

  (test-case grammar expected-graph))


(let ()
  ;;
  ;; Simple grammar with empty production.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> a x1
  ;; S -> ε
  ;; S -> c x3
  ;;

  (define grammar
    '((S (a x1) () (c x3))))

  (define expected-graph
    "
0 = { [S → • a x1, $] [S → • c x3, $] [S → •, $] }
a -> 1
c -> 2
1 = { [S → a • x1, $] }
x1 -> 4
4 = { [S → a x1 •, $] }
2 = { [S → c • x3, $] }
x3 -> 3
3 = { [S → c x3 •, $] }
")

  (test-case grammar expected-graph))


(let ()
  ;;
  ;; Grammar with nested non-terminals.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A B
  ;; A -> a
  ;; B -> b
  ;;

  (define grammar
    '((S (A B))
      (A (a))
      (B (b))))

  (define expected-graph
    "
0 = { [A → • a, b] [S → • A B, $] }
A -> 1
a -> 2
1 = { [B → • b, $] [S → A • B, $] }
B -> 3
b -> 4
3 = { [S → A B •, $] }
4 = { [B → b •, $] }
2 = { [A → a •, b] }
")

  (test-case grammar expected-graph))


(let ()
  ;;
  ;; Grammar with repeated non-terminals and lookaheads.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A A
  ;; A -> a
  ;;

  (define grammar
    '((S (A A))
      (A (a))))

  (define expected-graph
    "
0 = { [A → • a, a] [S → • A A, $] }
A -> 1
a -> 2
1 = { [A → • a, $] [S → A • A, $] }
A -> 3
a -> 4
3 = { [S → A A •, $] }
4 = { [A → a •, $] }
2 = { [A → a •, a] }
")

  (test-case grammar expected-graph))


(let ()
  ;;
  ;; Empty grammar.
  ;;
  ;;   Grammar:
  ;;

  (define grammar
    '())

  (define expected-graph
    "
0 = {  }
")

  (test-case grammar expected-graph))


(let ()
  ;;
  ;; Empty grammar with empty production.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> ε
  ;;

  (define grammar
    '((S ())))

  (define expected-graph
    "
0 = { [S → •, $] }
")

  (test-case grammar expected-graph))


(let ()
  ;;
  ;; Umich grammar (https://web.eecs.umich.edu/~weimerw/2009-4610/lectures/weimer-4610-09.pdf page 5).
  ;;
  ;;   Grammar:
  ;;
  ;; E -> int
  ;; E -> E + ( E )
  ;;

  (define lb
    (string->symbol "("))

  (define rb
    (string->symbol ")"))

  (define grammar
    `((E (int)
         (E + ,lb E ,rb))))

  (define expected-graph
    "
0 = { [E → • E + ( E ), $] [E → • E + ( E ), +] [E → • int, $] [E → • int, +] }
E -> 1
int -> 2
1 = { [E → E • + ( E ), $] [E → E • + ( E ), +] }
+ -> 3
3 = { [E → E + • ( E ), $] [E → E + • ( E ), +] }
( -> 4
4 = { [E → E + ( • E ), $] [E → E + ( • E ), +] [E → • E + ( E ), )] [E → • E + ( E ), +] [E → • int, )] [E → • int, +] }
E -> 5
int -> 6
5 = { [E → E + ( E • ), $] [E → E + ( E • ), +] [E → E • + ( E ), )] [E → E • + ( E ), +] }
) -> 7
+ -> 8
7 = { [E → E + ( E ) •, $] [E → E + ( E ) •, +] }
8 = { [E → E + • ( E ), )] [E → E + • ( E ), +] }
( -> 9
9 = { [E → E + ( • E ), )] [E → E + ( • E ), +] [E → • E + ( E ), )] [E → • E + ( E ), +] [E → • int, )] [E → • int, +] }
E -> 10
int -> 6
10 = { [E → E + ( E • ), )] [E → E + ( E • ), +] [E → E • + ( E ), )] [E → E • + ( E ), +] }
) -> 11
+ -> 8
11 = { [E → E + ( E ) •, )] [E → E + ( E ) •, +] }
6 = { [E → int •, )] [E → int •, +] }
2 = { [E → int •, $] [E → int •, +] }
")

  (test-case grammar expected-graph))


(let ()
  ;;
  ;; Clemson grammar (https://www.cs.clemson.edu/course/cpsc827/material/LRk/LR1.pdf page 3).
  ;;
  ;;   Grammar:
  ;;
  ;; G -> S
  ;; S -> E = E
  ;;    | f
  ;; E -> T
  ;;    | E + T
  ;; T -> f
  ;;    | T * f
  ;;

  (define grammar
    `((G (S))
      (S (E = E)
         (f))
      (E (T)
         (E + T))
      (T (f)
         (T * f))))

  (define expected-graph
    "
0 = { [E → • E + T, +] [E → • E + T, =] [E → • T, +] [E → • T, =] [G → • S, $] [S → • E = E, $] [S → • f, $] [T → • T * f, *] [T → • T * f, +] [T → • T * f, =] [T → • f, *] [T → • f, +] [T → • f, =] }
E -> 1
S -> 2
T -> 3
f -> 4
1 = { [E → E • + T, +] [E → E • + T, =] [S → E • = E, $] }
+ -> 7
= -> 8
7 = { [E → E + • T, +] [E → E + • T, =] [T → • T * f, *] [T → • T * f, +] [T → • T * f, =] [T → • f, *] [T → • f, +] [T → • f, =] }
T -> 16
f -> 17
16 = { [E → E + T •, +] [E → E + T •, =] [T → T • * f, *] [T → T • * f, +] [T → T • * f, =] }
* -> 5
5 = { [T → T * • f, *] [T → T * • f, +] [T → T * • f, =] }
f -> 6
6 = { [T → T * f •, *] [T → T * f •, +] [T → T * f •, =] }
17 = { [T → f •, *] [T → f •, +] [T → f •, =] }
8 = { [E → • E + T, $] [E → • E + T, +] [E → • T, $] [E → • T, +] [S → E = • E, $] [T → • T * f, $] [T → • T * f, *] [T → • T * f, +] [T → • f, $] [T → • f, *] [T → • f, +] }
E -> 9
T -> 10
f -> 11
9 = { [E → E • + T, $] [E → E • + T, +] [S → E = E •, $] }
+ -> 14
14 = { [E → E + • T, $] [E → E + • T, +] [T → • T * f, $] [T → • T * f, *] [T → • T * f, +] [T → • f, $] [T → • f, *] [T → • f, +] }
T -> 15
f -> 11
15 = { [E → E + T •, $] [E → E + T •, +] [T → T • * f, $] [T → T • * f, *] [T → T • * f, +] }
* -> 12
12 = { [T → T * • f, $] [T → T * • f, *] [T → T * • f, +] }
f -> 13
13 = { [T → T * f •, $] [T → T * f •, *] [T → T * f •, +] }
11 = { [T → f •, $] [T → f •, *] [T → f •, +] }
10 = { [E → T •, $] [E → T •, +] [T → T • * f, $] [T → T • * f, *] [T → T • * f, +] }
* -> 12
2 = { [G → S •, $] }
3 = { [E → T •, +] [E → T •, =] [T → T • * f, *] [T → T • * f, +] [T → T • * f, =] }
* -> 5
4 = { [S → f •, $] [T → f •, *] [T → f •, +] [T → f •, =] }
")

  (test-case grammar expected-graph))


(let ()
  ;;
  ;; Wikipedia grammar (https://en.wikipedia.org/wiki/Canonical_LR_parser).
  ;;
  ;;   Grammar:
  ;;
  ;; S → E
  ;; E → T
  ;; E → ( E )
  ;; T → n
  ;; T → + T
  ;; T → T + n
  ;;

  (define lb
    (string->symbol "("))

  (define rb
    (string->symbol ")"))

  (define grammar
    `((S (E))
      (E (T) (,lb E ,rb))
      (T (n) (+ T) (T + n))))

  (define expected-graph
    "
0 = { [E → • ( E ), $] [E → • T, $] [S → • E, $] [T → • + T, $] [T → • + T, +] [T → • T + n, $] [T → • T + n, +] [T → • n, $] [T → • n, +] }
( -> 1
+ -> 2
E -> 3
T -> 4
n -> 5
1 = { [E → ( • E ), $] [E → • ( E ), )] [E → • T, )] [T → • + T, )] [T → • + T, +] [T → • T + n, )] [T → • T + n, +] [T → • n, )] [T → • n, +] }
( -> 9
+ -> 10
E -> 11
T -> 12
n -> 13
9 = { [E → ( • E ), )] [E → • ( E ), )] [E → • T, )] [T → • + T, )] [T → • + T, +] [T → • T + n, )] [T → • T + n, +] [T → • n, )] [T → • n, +] }
( -> 9
+ -> 10
E -> 18
T -> 12
n -> 13
10 = { [T → + • T, )] [T → + • T, +] [T → • + T, )] [T → • + T, +] [T → • T + n, )] [T → • T + n, +] [T → • n, )] [T → • n, +] }
+ -> 10
T -> 17
n -> 13
17 = { [T → + T •, )] [T → + T •, +] [T → T • + n, )] [T → T • + n, +] }
+ -> 14
14 = { [T → T + • n, )] [T → T + • n, +] }
n -> 15
15 = { [T → T + n •, )] [T → T + n •, +] }
13 = { [T → n •, )] [T → n •, +] }
18 = { [E → ( E • ), )] }
) -> 19
19 = { [E → ( E ) •, )] }
12 = { [E → T •, )] [T → T • + n, )] [T → T • + n, +] }
+ -> 14
11 = { [E → ( E • ), $] }
) -> 16
16 = { [E → ( E ) •, $] }
2 = { [T → + • T, $] [T → + • T, +] [T → • + T, $] [T → • + T, +] [T → • T + n, $] [T → • T + n, +] [T → • n, $] [T → • n, +] }
+ -> 2
T -> 8
n -> 5
8 = { [T → + T •, $] [T → + T •, +] [T → T • + n, $] [T → T • + n, +] }
+ -> 6
6 = { [T → T + • n, $] [T → T + • n, +] }
n -> 7
7 = { [T → T + n •, $] [T → T + n •, +] }
5 = { [T → n •, $] [T → n •, +] }
3 = { [S → E •, $] }
4 = { [E → T •, $] [T → T • + n, $] [T → T • + n, +] }
+ -> 6
")

  (test-case grammar expected-graph))


(let ()
  ;;
  ;; Youtube grammar. (https://invidious.reallyaweso.me/watch?v=sh_X56otRdU)
  ;;
  ;;   Grammar:
  ;;
  ;; S -> X X
  ;; X -> a X
  ;; X -> b
  ;;
  ;;   Notes:
  ;;
  ;; Compared to the reference graph:
  ;; - Our items have single symbols as lookaheads
  ;;   whereas the reference uses sets of symbols.
  ;;   Ex. we have both ", a" and ", b" instead of ", a/b".
  ;; - We have a different state 0.
  ;;   This is because we do not create an additional S' nonterminal.
  ;; - Correspondence between states is the following:
  ;;
  ;;       / Reference state # / Our state # /
  ;;       / ----------------- / ----------- /
  ;;       /         0         /      0      /
  ;;       /         1         /      -      /
  ;;       /         2         /      1      /
  ;;       /         3         /      3      /
  ;;       /         4         /      2      /
  ;;       /         5         /      5      /
  ;;       /         6         /      6      /
  ;;       /         7         /      7      /
  ;;       /         8         /      8      /
  ;;       /         9         /      4      /
  ;;       / ----------------- / ----------- /
  ;;
  ;;

  (define grammar
    '((S (X X))
      (X (a X)
         (b))))

  (define expected-graph
    "
0 = { [S → • X X, $] [X → • a X, a] [X → • a X, b] [X → • b, a] [X → • b, b] }
X -> 1
a -> 2
b -> 3
1 = { [S → X • X, $] [X → • a X, $] [X → • b, $] }
X -> 5
a -> 6
b -> 7
5 = { [S → X X •, $] }
6 = { [X → a • X, $] [X → • a X, $] [X → • b, $] }
X -> 8
a -> 6
b -> 7
8 = { [X → a X •, $] }
7 = { [X → b •, $] }
2 = { [X → a • X, a] [X → a • X, b] [X → • a X, a] [X → • a X, b] [X → • b, a] [X → • b, b] }
X -> 4
a -> 2
b -> 3
4 = { [X → a X •, a] [X → a X •, b] }
3 = { [X → b •, a] [X → b •, b] }
")

  (test-case grammar expected-graph))
