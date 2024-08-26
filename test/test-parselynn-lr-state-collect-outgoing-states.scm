
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
  ;;   Initial state:
  ;;
  ;; { [S → • a, $] }
  ;;
  ;;

  (define grammar
    '((S (a))))

  (define initial-state
    (let ((state (parselynn:lr-state:make)))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'S '(a) parselynn:end-of-input))
      state))

  (define expected-graph
    "
0 = { [S → • a, $] }
a -> 1
1 = { [S → a •, $] }
")

  (test-1-case grammar initial-state expected-graph))


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
  ;;   Initial state:
  ;;
  ;; { [S → • a, $] [S → • b, $] [S → • c, $] }
  ;;
  ;;

  (define grammar
    '((S (a) (b) (c))))

  (define initial-state
    (let ((state (parselynn:lr-state:make)))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'S '(a) parselynn:end-of-input))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'S '(b) parselynn:end-of-input))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'S '(c) parselynn:end-of-input))
      state))

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

  (test-1-case grammar initial-state expected-graph))


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
  ;;   Initial state:
  ;;
  ;; { [S → • a x1, $] [S → • b, $] [S → • c x3, $] }
  ;;
  ;;

  (define grammar
    '((S (a x1) () (c x3))))

  (define initial-state
    (let ((state (parselynn:lr-state:make)))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'S '(a x1) parselynn:end-of-input))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'S '() parselynn:end-of-input))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'S '(c x3) parselynn:end-of-input))
      state))

  (define expected-graph
    "
0 = { [S → • a x1, $] [S → • c x3, $] [S → •, $] }
a -> 1
c -> 2
1 = { [S → a • x1, $] }
2 = { [S → c • x3, $] }
")

  (test-1-case grammar initial-state expected-graph))


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
  ;;   Initial state:
  ;;
  ;; { [S → • a x1, $] [S → •, $] [S → • c x3, $] }
  ;;
  ;;

  (define grammar
    '((S (a x1) (b) (c x3))))

  (define initial-state
    (let ((state (parselynn:lr-state:make)))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'S '(a x1) parselynn:end-of-input))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'S '() parselynn:end-of-input))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'S '(c x3) parselynn:end-of-input))
      state))

  (define expected-graph
    "
0 = { [S → • a x1, $] [S → • c x3, $] [S → •, $] }
a -> 1
c -> 2
1 = { [S → a • x1, $] }
2 = { [S → c • x3, $] }
")

  (test-1-case grammar initial-state expected-graph))


(let ()
  ;;
  ;; Simple grammar with single production and weird initial state.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> a
  ;;
  ;;   Initial state:
  ;;
  ;; { [S* → • S, $] [S → • a, $] }
  ;;
  ;;

  (define grammar
    '((S (a))))

  (define initial-state
    (let ((state (parselynn:lr-state:make)))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'S* '(S) parselynn:end-of-input))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'S '(a) parselynn:end-of-input))
      state))

  (define expected-graph
    "
0 = { [S → • a, $] [S* → • S, $] }
S -> 1
a -> 2
1 = { [S* → S •, $] }
2 = { [S → a •, $] }
")

  (test-1-case grammar initial-state expected-graph))


(let ()
  ;;
  ;; Simple grammar with multiple productions and weird initial state.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> a
  ;; S -> b
  ;; S -> c
  ;;
  ;;   Initial state:
  ;;
  ;; { [S* → • S, $] [S → • a, $] }
  ;;
  ;;

  (define grammar
    '((S (a) (b) (c))))

  (define initial-state
    (let ((state (parselynn:lr-state:make)))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'S* '(S) parselynn:end-of-input))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'S '(a) parselynn:end-of-input))
      state))

  (define expected-graph
    "
0 = { [S → • a, $] [S* → • S, $] }
S -> 1
a -> 2
1 = { [S* → S •, $] }
2 = { [S → a •, $] }
")

  (test-1-case grammar initial-state expected-graph))


(let ()
  ;;
  ;; Simple grammar with single production 3.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> a
  ;; S -> b
  ;; S -> c
  ;;
  ;;   Initial state:
  ;;
  ;; { [S* → • S, $] }
  ;;
  ;;

  (define grammar
    '((S (a) (b) (c))))

  (define initial-state
    (let ((state (parselynn:lr-state:make)))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'S* '(S) parselynn:end-of-input))
      state))

  (define expected-graph
    "
0 = { [S* → • S, $] }
S -> 1
1 = { [S* → S •, $] }
")

  (test-1-case grammar initial-state expected-graph))


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
  ;;   Initial state:
  ;;
  ;; { [S → • A B, $] [A → • a, b] }
  ;;

  (define grammar
    '((S (A B))
      (A (a))
      (B (b))))

  (define initial-state
    (let ((state (parselynn:lr-state:make)))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'S '(A B) parselynn:end-of-input))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'A '(a) 'b))
      state))

  (define expected-graph
    "
0 = { [A → • a, b] [S → • A B, $] }
A -> 1
a -> 2
1 = { [B → • b, $] [S → A • B, $] }
2 = { [A → a •, b] }
")

  (test-1-case grammar initial-state expected-graph))


(let ()
  ;;
  ;; Grammar with repeated non-terminals and lookaheads.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A A
  ;; A -> a
  ;;
  ;;   Initial state:
  ;;
  ;; { [S → A • A, $] [A → • a, $] }
  ;;

  (define grammar
    '((S (A A))
      (A (a))))

  (define initial-state
    (let ((state (parselynn:lr-state:make)))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'S '(A A) parselynn:end-of-input))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'A '(a) parselynn:end-of-input))
      state))

  (define expected-graph
    "
0 = { [A → • a, $] [S → • A A, $] }
A -> 1
a -> 2
1 = { [A → • a, $] [S → A • A, $] }
2 = { [A → a •, $] }
")

  (test-1-case grammar initial-state expected-graph))


(let ()
  ;;
  ;; Empty grammar.
  ;;
  ;;   Grammar:
  ;;
  ;;
  ;;   Initial state:
  ;;
  ;; { [S → • a, $] }
  ;;
  ;;

  (define grammar
    '())

  (define initial-state
    (let ((state (parselynn:lr-state:make)))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'S '(a) parselynn:end-of-input))
      state))

  (define expected-graph
    "
0 = { [S → • a, $] }
a -> 1
1 = { [S → a •, $] }
")

  (test-1-case grammar initial-state expected-graph))


(let ()
  ;;
  ;; Empty grammar with empty production.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> ε
  ;;
  ;;   Initial state:
  ;;
  ;; { [S → •, $] }
  ;;
  ;;

  (define grammar
    '((S ())))

  (define initial-state
    (let ((state (parselynn:lr-state:make)))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'S '() parselynn:end-of-input))
      state))

  (define expected-graph
    "
0 = { [S → •, $] }
")

  (test-1-case grammar initial-state expected-graph))


(let ()
  ;;
  ;; Umich grammar (https://web.eecs.umich.edu/~weimerw/2009-4610/lectures/weimer-4610-09.pdf page 5, then closure at page 18).
  ;; State 3. (https://smlweb.cpsc.ucalgary.ca/lr1.php?grammar=E+-%3E+int.%0AE+-%3E+E+%2B+%28+E+%29.&substs=)
  ;;
  ;;   Grammar:
  ;;
  ;; E -> int
  ;; E -> E + ( E )
  ;;
  ;;   Initial state:
  ;;
  ;; { [E → E + • ( E ), $] [E → E • ( E ), +] }
  ;;

  (define lb
    (string->symbol "("))

  (define rb
    (string->symbol ")"))

  (define grammar
    `((E (int)
         (E + ,lb E ,rb))))

  (define initial-state
    (let ((state (parselynn:lr-state:make)))
      (parselynn:lr-state:add!
       state
       (parselynn:lr-item:advance
        (parselynn:lr-item:make
         'E `(E ,lb E ,rb) parselynn:end-of-input)))
      (parselynn:lr-state:add!
       state
       (parselynn:lr-item:advance
        (parselynn:lr-item:make
         'E `(E ,lb E ,rb) '+)))
      state))

  (define expected-graph
    "
0 = { [E → E • ( E ), $] [E → E • ( E ), +] }
( -> 1
1 = { [E → E ( • E ), $] [E → E ( • E ), +] [E → • E + ( E ), )] [E → • E + ( E ), +] [E → • int, )] [E → • int, +] }
")

  (test-1-case grammar initial-state expected-graph))
