
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
0 = { [S → • a, $] [♼ → • S, $] }
S -> 1
a -> 2
1 = { [♼ → S •, $] }
2 = { [S → a •, $] }
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
0 = { [S → • a, $] [S → • b, $] [S → • c, $] [♼ → • S, $] }
S -> 1
a -> 2
b -> 3
c -> 4
1 = { [♼ → S •, $] }
2 = { [S → a •, $] }
3 = { [S → b •, $] }
4 = { [S → c •, $] }
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
0 = { [S → • a x1, $] [S → • b, $] [S → • c x3, $] [♼ → • S, $] }
S -> 1
a -> 2
b -> 3
c -> 4
1 = { [♼ → S •, $] }
2 = { [S → a • x1, $] }
x1 -> 6
6 = { [S → a x1 •, $] }
3 = { [S → b •, $] }
4 = { [S → c • x3, $] }
x3 -> 5
5 = { [S → c x3 •, $] }
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
0 = { [S → • a x1, $] [S → • c x3, $] [S → •, $] [♼ → • S, $] }
S -> 1
a -> 2
c -> 3
1 = { [♼ → S •, $] }
2 = { [S → a • x1, $] }
x1 -> 5
5 = { [S → a x1 •, $] }
3 = { [S → c • x3, $] }
x3 -> 4
4 = { [S → c x3 •, $] }
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
0 = { [A → • a, b] [S → • A B, $] [♼ → • S, $] }
A -> 1
S -> 2
a -> 3
1 = { [B → • b, $] [S → A • B, $] }
B -> 4
b -> 5
4 = { [S → A B •, $] }
5 = { [B → b •, $] }
2 = { [♼ → S •, $] }
3 = { [A → a •, b] }
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
