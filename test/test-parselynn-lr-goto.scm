
;;
;; Define test-case syntax for GOTO tests.
;;

(define-syntax test-case-goto
  (syntax-rules ()
    ((_ grammar* state* symbol* expected-state*)
     (let ()
       (define grammar grammar*)
       (define state state*)
       (define symbol symbol*)
       (define expected-state expected-state*)

       (define goto-state
         (parselynn:lr-goto state symbol grammar))

       (define text
         (with-output-stringified
          (parselynn:lr-state:print goto-state)))

       (assert= text expected-state)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Test cases for GOTO:
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
  ;; { [S* → • S, $] [S → • a, $] }
  ;;
  ;;   Symbol: S
  ;;
  ;;   Expected GOTO state:
  ;;
  ;; { [S → a •, $] }
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

  (define symbol 'S)

  (define expected-state
    "{ [S* → S •, $] }")

  (test-case-goto grammar initial-state symbol expected-state))


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
  ;;   Initial state:
  ;;
  ;; { [S → • A B, $] [A → •, b] }
  ;;
  ;;   Symbol: A
  ;;
  ;;   Expected GOTO state:
  ;;
  ;; { [S → A • B, $] [B → • b, $] }
  ;;

  (define grammar
    '((S (A B))
      (A ())
      (B (b))))

  (define initial-state
    (let ((state (parselynn:lr-state:make)))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'S '(A B) parselynn:end-of-input))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'A '() 'b))
      state))

  (define symbol 'A)

  (define expected-state
    "{ [B → • b, $] [S → A • B, $] }")

  (test-case-goto grammar initial-state symbol expected-state))


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
  ;;   Symbol: A
  ;;
  ;;   Expected GOTO state:
  ;;
  ;; { [S → A • B, $] [B → • b, $] }
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

  (define symbol 'A)

  (define expected-state
    "{ [B → • b, $] [S → A • B, $] }")

  (test-case-goto grammar initial-state symbol expected-state))


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
  ;;   Initial state:
  ;;
  ;; { [S → • A B, $] [A → • a, c] }
  ;;
  ;;   Symbol: A
  ;;
  ;;   Expected GOTO state:
  ;;
  ;; { [S → A • B, $] [B → • C d, $] [C → • c, d] }
  ;;

  (define grammar
    '((S (A B))
      (A (a))
      (B (C d))
      (C (c))))

  (define initial-state
    (let ((state (parselynn:lr-state:make)))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'S '(A B) parselynn:end-of-input))
      (parselynn:lr-state:add! state
        (parselynn:lr-item:make 'A '(a) 'c))
      state))

  (define symbol 'A)

  (define expected-state
    "{ [B → • C d, $] [C → • c, d] [S → A • B, $] }")

  (test-case-goto grammar initial-state symbol expected-state))


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
  ;;   Symbol: A
  ;;
  ;;   Expected GOTO state:
  ;;
  ;; { [S → A A •, $] }
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

  (define symbol 'A)

  (define expected-state
    "{ [A → • a, $] [S → A • A, $] }")

  (test-case-goto grammar initial-state symbol expected-state))


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
  ;;   Symbol: A
  ;;
  ;;   Expected GOTO state:
  ;;
  ;; { ... }
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

  (define symbol lb)

  (define expected-state
    "{ [E → E ( • E ), $] [E → E ( • E ), +] [E → • E + ( E ), )] [E → • E + ( E ), +] [E → • int, )] [E → • int, +] }")

  (test-case-goto grammar initial-state symbol expected-state))
