
(define-type9 <parselynn:lr-state>
  (parselynn:lr-state:constructor
   set
   )

  parselynn:lr-state?

  (set parselynn:lr-state:set)       ;; Set of LR items.

  )


(define (parselynn:lr-state:make)
  (define set (make-hashset))
  (parselynn:lr-state:constructor set))


(define (parselynn:lr-state:add! state item)
  (define set (parselynn:lr-state:set state))
  (hashset-add! set item))


(define (parselynn:lr-state:has? state item)
  (define set (parselynn:lr-state:set state))
  (hashset-has? set item))


(define parselynn:lr-state:print
  (case-lambda
   ((state)
    (parselynn:lr-state:print state (current-output-port)))

   ((state port)
    (define (print-item item)
      (parselynn:lr-item:print item))

    (define unsorted-items
      (hashset->list
       (parselynn:lr-state:set state)))

    (define stringified-items
      (map
       (lambda (item)
         (with-output-stringified
          (print-item item)))
       unsorted-items))

    (define items
      (euphrates:list-sort
       stringified-items
       string<?))

    (parameterize ((current-output-port port))
      (display "{ ")
      (display (words->string items))
      (display " }")))))


(define (parselynn:lr-state:equal? state1 state2)
  (define set1 (parselynn:lr-state:set state1))
  (define set2 (parselynn:lr-state:set state2))
  (hashset-equal? set1 set2))


;;
;; (WIKIPEDIA REFERENCE)
;;
;; The rest of the item sets can be created by the following algorithm
;;
;; 1. For each terminal and nonterminal symbol A appearing after a '•' in each already existing item set k,
;;    create a new item set m by adding to m all the rules of k where '•' is followed by A,
;;    but only if m will not be the same as an already existing item set after step 3.
;; 2. shift all the '•'s for each rule in the new item set one symbol to the right
;; 3. create the closure of the new item set
;; 4. Repeat from step 1 for all newly created item sets, until no more new sets appear
;;

(define (parselynn:lr-closure bnf-alist initial-item)
  (define first-set
    (bnf-alist:compute-first-set bnf-alist))

  (parselynn:lr-closure/given-first
   first-set bnf-alist initial-item))


(define (parselynn:lr-closure/given-first first-set bnf-alist initial-item)
  (define ret
    (parselynn:lr-state:make))

  (define terminals
    (list->hashset
     (bnf-alist:terminals bnf-alist)))

  (define nonterminals
    (list->hashset
     (bnf-alist:nonterminals bnf-alist)))

  (define (terminal? X)
    (hashset-has? terminals X))

  (define (nonterminal? X)
    (hashset-has? nonterminals X))

  (let loop ((item initial-item))
    (unless (parselynn:lr-state:has? ret item)
      (let ()

        (define _0
          (parselynn:lr-state:add! ret item))
        (define next
          (parselynn:lr-item:next-symbol item))

        (when (and next (nonterminal? next))
          (let ()
            (define productions
              (bnf-alist:assoc-productions next bnf-alist))

            (define lookaheads
              (parselynn:lr-item:next-lookaheads
               terminals nonterminals first-set item))

            (define new-items
              (cartesian-map
               (lambda (production lookahead)
                 (define lhs next)
                 (define rhs production)

                 (parselynn:lr-item:make
                  lhs rhs lookahead))

               productions
               lookaheads))

            (for-each loop new-items))))))

  ret)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Test cases:
;;


(define-syntax test-case
  (syntax-rules ()
    ((_ grammar* item* expected-closure*)
     (let ()
       (define grammar grammar*)
       (define item item*)
       (define expected-closure expected-closure*)

       (define closure
         (parselynn:lr-closure
          grammar item))

       (define text
         (with-output-stringified
          (parselynn:lr-state:print closure)))

       (assert= text expected-closure)))))

(let ()
  ;;
  ;; Simple grammar with single production.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> a
  ;;
  ;;   Initial item:
  ;;
  ;; [S* → • S, $]
  ;;

  (define grammar
    '((S (a))))

  (define item
    (parselynn:lr-item:make
     'S* '(S) parselynn:end-of-input))

  (define expected-closure
    "{ [S → • a, $] [S* → • S, $] }")

  (test-case grammar item expected-closure))


(let ()
  ;;
  ;; Grammar with epsilon (empty string) production.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A B
  ;; A -> ε
  ;; B -> b
  ;;
  ;;   Initial item:
  ;;
  ;; [S* → • S, $]
  ;;

  (define grammar
    '((S (A B))
      (A ())
      (B (b))))

  (define item
    (parselynn:lr-item:make
     'S* '(S) parselynn:end-of-input))

  (define expected-closure
    "{ [A → •, b] [S → • A B, $] [S* → • S, $] }")

  (test-case grammar item expected-closure))


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
  ;;   Initial item:
  ;;
  ;; [S* → • S, $]
  ;;

  (define grammar
    '((S (A B))
      (A (a))
      (B (b))))

  (define item
    (parselynn:lr-item:make
     'S* '(S) parselynn:end-of-input))

  (define expected-closure
    "{ [A → • a, b] [S → • A B, $] [S* → • S, $] }")

  (test-case grammar item expected-closure))


(let ()
  ;;
  ;; Grammar with terminals and non-terminals after the dot.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A B
  ;; A -> a
  ;; B -> C d
  ;; C -> c
  ;;
  ;;   Initial item:
  ;;
  ;; [S* → • S, $]
  ;;

  (define grammar
    '((S (A B))
      (A (a))
      (B (C d))
      (C (c))))

  (define item
    (parselynn:lr-item:make
     'S* '(S) parselynn:end-of-input))

  (define expected-closure
    "{ [A → • a, c] [S → • A B, $] [S* → • S, $] }")

  (test-case grammar item expected-closure))


(let ()
  ;;
  ;; Grammar with repeated non-terminals and lookaheads.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A A
  ;; A -> a
  ;;
  ;;   Initial item:
  ;;
  ;; [S* → S •, $]
  ;;

  (define grammar
    '((S (A A))
      (A (a))))

  (define item
    (parselynn:lr-item:advance
     (parselynn:lr-item:make
      'S* '(S) parselynn:end-of-input)))

  (define expected-closure
    "{ [S* → S •, $] }")   ;; Closure remains the same as item.

  (test-case grammar item expected-closure))


(let ()
  ;;
  ;; Empty Grammar
  ;;
  ;;   Grammar:
  ;;
  ;; (No productions)
  ;;
  ;;   Initial item:
  ;;
  ;; [S* → • S, $]
  ;;

  (define grammar '())

  (define item
    (parselynn:lr-item:make
     'S* '(S) parselynn:end-of-input))

  (define expected-closure
    "{ [S* → • S, $] }")

  (test-case grammar item expected-closure))


(let ()
  ;;
  ;; Invalid Production Symbol
  ;;
  ;;   Grammar:
  ;;
  ;; S -> a Z   ;; Z is not defined
  ;;
  ;;   Initial item:
  ;;
  ;; [S* → • S, $]
  ;;

  (define grammar
    '((S (a Z))))

  (define item
    (parselynn:lr-item:make
     'S* '(S) parselynn:end-of-input))

  (define expected-closure
    "{ [S → • a Z, $] [S* → • S, $] }")

  (test-case grammar item expected-closure))


(let ()
  ;;
  ;; Complex Nesting and Recursion
  ;;
  ;;   Grammar:
  ;;
  ;; A -> B
  ;; B -> C D
  ;; C -> D A | ε
  ;; D -> a
  ;;
  ;;   Initial item:
  ;;
  ;; [A* → • A, $]
  ;;

  (define grammar
    '((A (B))
      (B (C D))
      (C (D A) ())
      (D (a))))

  (define item
    (parselynn:lr-item:make
     'A* '(A) parselynn:end-of-input))

  (define expected-closure
    "{ [A → • B, $] [A* → • A, $] [B → • C D, $] [C → • D A, a] [C → •, a] [D → • a, a] }")

  (test-case grammar item expected-closure))


(let ()
  ;;
  ;; Left-Recursive Grammar
  ;;
  ;;   Grammar:
  ;;
  ;; S -> S a | b
  ;;
  ;;   Initial item:
  ;;
  ;; [S* → • S, $]
  ;;

  (define grammar
    '((S (S a) (b))))

  (define item
    (parselynn:lr-item:make
     'S* '(S) parselynn:end-of-input))

  (define expected-closure
    "{ [S → • S a, $] [S → • S a, a] [S → • b, $] [S → • b, a] [S* → • S, $] }")

  (test-case grammar item expected-closure))


(let ()
  ;;
  ;; Multiple Lookaheads
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A B
  ;; A -> a | ε
  ;; B -> b
  ;;
  ;;   Initial item:
  ;;
  ;; [S* → • S, $]
  ;;

  (define grammar
    '((S (A B))
      (A (a) ())
      (B (b))))

  (define item
    (parselynn:lr-item:make
     'S* '(S) parselynn:end-of-input))

  (define expected-closure
    "{ [A → • a, b] [A → •, b] [S → • A B, $] [S* → • S, $] }")

  (test-case grammar item expected-closure))


(let ()
  ;;
  ;; Terminals in Different Positions
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A b
  ;; A -> a
  ;;
  ;;   Initial item:
  ;;
  ;; [S* → • S, $]
  ;;

  (define grammar
    '((S (A b))
      (A (a))))

  (define item
    (parselynn:lr-item:make
     'S* '(S) parselynn:end-of-input))

  (define expected-closure
    "{ [A → • a, b] [S → • A b, $] [S* → • S, $] }")

  (test-case grammar item expected-closure))


(let ()
  ;;
  ;; Grammar with undefined non-terminal
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A B
  ;; A -> a
  ;; B -> c     ;; No production for c
  ;;
  ;;   Initial item:
  ;;
  ;; [S* → • S, $]
  ;;

  (define grammar
    '((S (A B))
      (A (a))
      (B (c))))  ;; 'c' is not defined

  (define item
    (parselynn:lr-item:make
     'S* '(S) parselynn:end-of-input))

  (define expected-closure
    "{ [A → • a, c] [S → • A B, $] [S* → • S, $] }")

  (test-case grammar item expected-closure))


(let ()
  ;;
  ;; Clemson grammar (https://www.cs.clemson.edu/course/cpsc827/material/LRk/LR1.pdf page 3, then closure at page 8).
  ;; State 0.
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
  ;;   Initial item:
  ;;
  ;; [G → • S, $]
  ;;

  (define grammar
    `((G (S))
      (S (E = E)
         (f))
      (E (T)
         (E + T))
      (T (f)
         (T * f))))

  (define item
    (parselynn:lr-item:make
     'G '(S) parselynn:end-of-input))

  (define expected-closure
    (words->string
     (list
      "{"
      "[E → • E + T, +]"
      "[E → • E + T, =]"
      "[E → • T, +]"
      "[E → • T, =]"
      "[G → • S, $]"
      "[S → • E = E, $]"
      "[S → • f, $]"
      "[T → • T * f, *]"
      "[T → • T * f, +]"
      "[T → • T * f, =]"
      "[T → • f, *]"
      "[T → • f, +]"
      "[T → • f, =]"
      "}")))

  (test-case grammar item expected-closure))


(let ()
  ;;
  ;; Clemson grammar (https://www.cs.clemson.edu/course/cpsc827/material/LRk/LR1.pdf page 3, then closure at page 8).
  ;; State 4.
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
  ;;   Initial item:
  ;;
  ;; [S → E = • E, $]
  ;;

  (define grammar
    `((G (S))
      (S (E = E)
         (f))
      (E (T)
         (E + T))
      (T (f)
         (T * f))))

  (define item
    (parselynn:lr-item:advance
     (parselynn:lr-item:advance
      (parselynn:lr-item:make
       'S '(E = E) parselynn:end-of-input))))

  (define expected-closure
    (words->string
     (list
      "{"
      "[E → • E + T, $]"
      "[E → • E + T, +]"
      "[E → • T, $]"
      "[E → • T, +]"
      "[S → E = • E, $]"
      "[T → • T * f, $]"
      "[T → • T * f, *]"
      "[T → • T * f, +]"
      "[T → • f, $]"
      "[T → • f, *]"
      "[T → • f, +]"
      "}")))

  (test-case grammar item expected-closure))


(let ()
  ;;
  ;; Umich grammar (https://web.eecs.umich.edu/~weimerw/2009-4610/lectures/weimer-4610-09.pdf page 5, then closure at page 18).
  ;; State 0.
  ;;
  ;;   Grammar:
  ;;
  ;; E -> int | E + ( E )
  ;;
  ;;   Initial item:
  ;;
  ;; [S → • E, $]
  ;;

  (define lb
    (string->symbol "("))

  (define rb
    (string->symbol ")"))

  (define grammar
    `((E (int)
         (E + ,lb E ,rb))))

  (define item
    (parselynn:lr-item:make
     'S '(E) parselynn:end-of-input))

  (define expected-closure
    "{ [E → • E + ( E ), $] [E → • E + ( E ), +] [E → • int, $] [E → • int, +] [S → • E, $] }")

  (test-case grammar item expected-closure))


(let ()
  ;;
  ;; Umich grammar (https://web.eecs.umich.edu/~weimerw/2009-4610/lectures/weimer-4610-09.pdf page 5, then states at page 34).
  ;; State 1. (case 1)
  ;;
  ;;   Grammar:
  ;;
  ;; E -> int | E + ( E )
  ;;
  ;;   Initial item:
  ;;
  ;; [E → int •, $]
  ;;

  (define lb
    (string->symbol "("))

  (define rb
    (string->symbol ")"))

  (define grammar
    `((E (int)
         (E + ,lb E ,rb))))

  (define item
    (parselynn:lr-item:advance
     (parselynn:lr-item:make
      'E '(int) parselynn:end-of-input)))

  (define expected-closure
    "{ [E → int •, $] }")

  (test-case grammar item expected-closure))


(let ()
  ;;
  ;; Umich grammar (https://web.eecs.umich.edu/~weimerw/2009-4610/lectures/weimer-4610-09.pdf page 5, then states at page 34).
  ;; State 2. (only initial item)
  ;;
  ;;   Grammar:
  ;;
  ;; E -> int | E + ( E )
  ;;
  ;;   Initial item:
  ;;
  ;; [S → E •, $]
  ;;

  (define lb
    (string->symbol "("))

  (define rb
    (string->symbol ")"))

  (define grammar
    `((E (int)
         (E + ,lb E ,rb))))

  (define item
    (parselynn:lr-item:advance
     (parselynn:lr-item:make
      'S '(E) parselynn:end-of-input)))

  (define expected-closure
    "{ [S → E •, $] }")

  (test-case grammar item expected-closure))


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
  ;;   Initial item:
  ;;
  ;; [S* → • S, $]
  ;;
  ;; Note: wikipedia uses a different rule for closure - via FOLLOW sets.
  ;;

  (define lb
    (string->symbol "("))

  (define rb
    (string->symbol ")"))

  (define grammar
    `((S (E))
      (E (T) (,lb E ,rb))
      (T (n) (+ T) (T + n))))

  (define item
    (parselynn:lr-item:make
     'S* '(S) parselynn:end-of-input))

  (define expected-closure
    "{ [E → • ( E ), $] [E → • T, $] [S → • E, $] [S* → • S, $] [T → • + T, $] [T → • + T, +] [T → • T + n, $] [T → • T + n, +] [T → • n, $] [T → • n, +] }")

  (test-case grammar item expected-closure))


(let ()
  ;;
  ;; Youtube grammar. (https://invidious.reallyaweso.me/watch?v=sh_X56otRdU)
  ;; State 0.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> X X
  ;; X -> a X
  ;; X -> b
  ;;
  ;;   Initial item:
  ;;
  ;; [S* → • S, $]
  ;;

  (define grammar
    '((S (X X))
      (X (a X)
         (b))))

  (define item
    (parselynn:lr-item:make
     'S* '(S) parselynn:end-of-input))

  (define expected-closure
    "{ [S → • X X, $] [S* → • S, $] [X → • a X, a] [X → • a X, b] [X → • b, a] [X → • b, b] }")

  (test-case grammar item expected-closure))


(let ()
  ;;
  ;; Youtube grammar. (https://invidious.reallyaweso.me/watch?v=sh_X56otRdU)
  ;; State 1.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> X X
  ;; X -> a X
  ;; X -> b
  ;;
  ;;   Initial item:
  ;;
  ;; [S → S •, $]
  ;;

  (define grammar
    '((S (X X))
      (X (a X)
         (b))))

  (define item
    (parselynn:lr-item:advance
     (parselynn:lr-item:make
      'S '(S) parselynn:end-of-input)))

  (define expected-closure
    "{ [S → S •, $] }")

  (test-case grammar item expected-closure))


(let ()
  ;;
  ;; Youtube grammar. (https://invidious.reallyaweso.me/watch?v=sh_X56otRdU)
  ;; State 2.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> X X
  ;; X -> a X
  ;; X -> b
  ;;
  ;;   Initial item:
  ;;
  ;; [S → X • X, $]
  ;;

  (define grammar
    '((S (X X))
      (X (a X)
         (b))))

  (define item
    (parselynn:lr-item:advance
     (parselynn:lr-item:make
      'S '(X X) parselynn:end-of-input)))

  (define expected-closure
    "{ [S → X • X, $] [X → • a X, $] [X → • b, $] }")

  (test-case grammar item expected-closure))


(let ()
  ;;
  ;; Youtube grammar. (https://invidious.reallyaweso.me/watch?v=sh_X56otRdU)
  ;; State 3. (case 1)
  ;;
  ;;   Grammar:
  ;;
  ;; S -> X X
  ;; X -> a X
  ;; X -> b
  ;;
  ;;   Initial item:
  ;;
  ;; [X → b •, a]
  ;;

  (define grammar
    '((S (X X))
      (X (a X)
         (b))))

  (define item
    (parselynn:lr-item:advance
     (parselynn:lr-item:make
      'X '(b) 'a)))

  (define expected-closure
    "{ [X → b •, a] }")

  (test-case grammar item expected-closure))


(let ()
  ;;
  ;; Youtube grammar. (https://invidious.reallyaweso.me/watch?v=sh_X56otRdU)
  ;; State 4. (case 2)
  ;;
  ;;   Grammar:
  ;;
  ;; S -> X X
  ;; X -> a X
  ;; X -> b
  ;;
  ;;   Initial item:
  ;;
  ;; [X → a • X, b]
  ;;

  (define grammar
    '((S (X X))
      (X (a X)
         (b))))

  (define item
    (parselynn:lr-item:advance
     (parselynn:lr-item:make
      'X '(a X) 'b)))

  (define expected-closure
    "{ [X → a • X, b] [X → • a X, b] [X → • b, b] }")

  (test-case grammar item expected-closure))


(let ()
  ;;
  ;; Youtube grammar. (https://invidious.reallyaweso.me/watch?v=sh_X56otRdU)
  ;; State 5.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> X X
  ;; X -> a X
  ;; X -> b
  ;;
  ;;   Initial item:
  ;;
  ;; [S → X X •, $]
  ;;

  (define grammar
    '((S (X X))
      (X (a X)
         (b))))

  (define item
    (parselynn:lr-item:advance
     (parselynn:lr-item:advance
      (parselynn:lr-item:make
       'S '(X X) '$))))

  (define expected-closure
    "{ [S → X X •, $] }")

  (test-case grammar item expected-closure))


(let ()
  ;;
  ;; Youtube grammar. (https://invidious.reallyaweso.me/watch?v=sh_X56otRdU)
  ;; State 6.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> X X
  ;; X -> a X
  ;; X -> b
  ;;
  ;;   Initial item:
  ;;
  ;; [X → a • X, $]
  ;;

  (define grammar
    '((S (X X))
      (X (a X)
         (b))))

  (define item
    (parselynn:lr-item:advance
     (parselynn:lr-item:make
      'X '(a X) parselynn:end-of-input)))

  (define expected-closure
    "{ [X → a • X, $] [X → • a X, $] [X → • b, $] }")

  (test-case grammar item expected-closure))

