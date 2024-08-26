
;;
;; Define test-case syntax for GOTO tests.
;;

(define-syntax test-case-goto
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

  (test-case-goto grammar initial-state expected-graph))

