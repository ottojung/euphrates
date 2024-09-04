
;;
;; Define test-case syntax.
;;


(define-syntax test-case
  (syntax-rules ()
    ((_ grammar* input* expected*)
     (let ()
       (define grammar grammar*)
       (define input input*)
       (define expected expected*)

       (define table
         (parselynn:lr-compute-parsing-table grammar))

       (define input-iterator
         (list->iterator input))

       (define result
         (parselynn:lr-interpret table input-iterator))

       (unless (equal? result expected)
         (debug "\n\n\n----------------------------------\nactual:\n~s\n\n" result))

       (assert= result expected)))))


;;;;;;;;;;;;;;;;;
;;
;; Test cases:
;;


(let ()
  ;;
  ;; Empty grammar.
  ;;
  ;;   Grammar:
  ;;

  (define grammar
    '())

  (define input
    '(a b c d))

  (define expected
    (parselynn:lr-reject-action:make))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Empty grammar.
  ;;
  ;;   Grammar:
  ;;

  (define grammar
    '())

  (define input
    '())

  (define expected
    (parselynn:lr-reject-action:make))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Minimal self referential grammar.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> S
  ;;

  (define grammar
    '((S (S))))

  (define input
    '())

  (define expected
    (parselynn:lr-reject-action:make))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Minimal self referential grammar.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> S
  ;;

  (define grammar
    '((S (S))))

  (define input
    '(S))

  (define expected
    (parselynn:lr-reject-action:make))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Minimal grammar with empty production.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> ε
  ;;

  (define grammar
    '((S ())))

  (define input
    '())

  (define expected
    `(S ()))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Minimal grammar with empty production.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> ε
  ;;

  (define grammar
    '((S ())))

  (define input
    '(a))

  (define expected
    (parselynn:lr-reject-action:make))

  (test-case grammar input expected))


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

  (define input
    '(a))

  (define expected
    '(S (a)))

  (test-case grammar input expected))


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

  (define input
    '(b))

  (define expected
    (parselynn:lr-reject-action:make))

  (test-case grammar input expected))


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

  (define input
    '())

  (define expected
    (parselynn:lr-reject-action:make))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Simple grammar with two productions.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> a b
  ;;

  (define grammar
    '((S (a b))))

  (define input
    '(a b))

  (define expected
    `(S (a b)))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Simple grammar with two productions.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> a b c
  ;;

  (define grammar
    '((S (a b c))))

  (define input
    '(a b c))

  (define expected
    `(S (a b c)))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Self referential grammar [2].
  ;;
  ;;   Grammar:
  ;;
  ;; S -> S
  ;; S -> x
  ;;

  (define grammar
    '((S (S) (x))))

  (define input
    '(x))

  (define expected
    `(S (x)))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Self referential grammar [2].
  ;;
  ;;   Grammar:
  ;;
  ;; S -> x
  ;; S -> S
  ;;

  (define grammar
    '((S (x) (S))))

  (define input
    '(x))

  (define expected
    `(S (x)))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Self referential grammar [2].
  ;;
  ;;   Grammar:
  ;;
  ;; S -> x
  ;; S -> S
  ;;

  (define grammar
    '((S (x) (S))))

  (define input
    '())

  (define expected
    (parselynn:lr-reject-action:make))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Simple grammar with two productions.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> E
  ;; E -> a
  ;;

  (define grammar
    '((S (E))
      (E (a))))

  (define input
    '(a))

  (define expected
    `(S ((E (a)))))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Simple grammar with two productions.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> E
  ;; E -> a b
  ;;

  (define grammar
    '((S (E))
      (E (a b))))

  (define input
    '(a b))

  (define expected
    `(S ((E (a b)))))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Simple grammar with two productions.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> E b
  ;; E -> a
  ;;

  (define grammar
    '((S (E b))
      (E (a))))

  (define input
    '(a b))

  (define expected
    `(S ((E (a)) b)))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Simple grammar with two productions.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> E c
  ;; E -> a b
  ;;

  (define grammar
    '((S (E c))
      (E (a b))))

  (define input
    '(a b c))

  (define expected
    `(S ((E (a b)) c)))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Simple grammar with two productions.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> E E
  ;; E -> a b
  ;;

  (define grammar
    '((S (E E))
      (E (a b))))

  (define input
    '(a b a b))

  (define expected
    `(S ((E (a b)) (E (a b)))))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Simple grammar with two productions.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> E E
  ;; E -> a b
  ;;

  (define grammar
    '((S (E E))
      (E (a b))))

  (define input
    '(a b a b))

  (define expected
    `(S ((E (a b)) (E (a b)))))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Simple grammar with two productions.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> E E E
  ;; E -> a b
  ;;

  (define grammar
    '((S (E E E))
      (E (a b))))

  (define input
    '(a b a b a b))

  (define expected
    `(S ((E (a b)) (E (a b)) (E (a b)))))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Simple grammar with two productions and epsilon.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> E c
  ;; E -> a b | ε
  ;;

  (define grammar
    '((S (E c))
      (E (a b) ())))

  (define input
    '(a b c))

  (define expected
    `(S ((E (a b)) c)))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Simple grammar with two productions and epsilon.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> E c
  ;; E -> a b | ε
  ;;

  (define grammar
    '((S (E c))
      (E (a b) ())))

  (define input
    '(c))

  (define expected
    `(S ((E ()) c)))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Simple grammar with 3 productions.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> E c
  ;; E -> a b
  ;;

  (define grammar
    '((S (E c))
      (E (a b))))

  (define input
    '(a b c))

  (define expected
    `(S ((E (a b)) c)))

  (test-case grammar input expected))


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

  (define input
    '(a))

  (define expected
    `(S (a)))

  (test-case grammar input expected))


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

  (define input
    '(b))

  (define expected
    `(S (b)))

  (test-case grammar input expected))


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

  (define input
    '(c))

  (define expected
    `(S (c)))

  (test-case grammar input expected))


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

  (define input
    '(d))

  (define expected
    (parselynn:lr-reject-action:make))

  (test-case grammar input expected))


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

  (define input
    '(a x1))

  (define expected
    (list 'S input))

  (test-case grammar input expected))


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

  (define input
    '(b))

  (define expected
    (list 'S input))

  (test-case grammar input expected))


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

  (define input
    '(a x1))

  (define expected
    (list 'S input))

  (test-case grammar input expected))


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

  (define input
    '())

  (define expected
    (list 'S input))

  (test-case grammar input expected))


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

  (define input
    '(c x3))

  (define expected
    (list 'S input))

  (test-case grammar input expected))


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

  (define input
    '(b))

  (define expected
    (parselynn:lr-reject-action:make))

  (test-case grammar input expected))


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

  (define input
    '(a b))

  (define expected
    `(S ((A (a)) (B (b)))))

  (test-case grammar input expected))


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

  (define input
    '(b))

  (define expected
    (parselynn:lr-reject-action:make))

  (test-case grammar input expected))


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

  (define input
    '(b))

  (define expected
    (parselynn:lr-reject-action:make))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Self referential grammar [3].
  ;;
  ;;   Grammar:
  ;;
  ;; S -> S
  ;; S -> x S
  ;;

  (define grammar
    '((S (S) (x S))))

  (define input
    '(x))

  (define expected
    (parselynn:lr-reject-action:make))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Self referential grammar [3].
  ;;
  ;;   Grammar:
  ;;
  ;; S -> S
  ;; S -> x S
  ;;

  (define grammar
    '((S (S) (x S))))

  (define input
    '(x x))

  (define expected
    (parselynn:lr-reject-action:make))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Self referential grammar [3].
  ;;
  ;;   Grammar:
  ;;
  ;; S -> S
  ;; S -> x S
  ;;

  (define grammar
    '((S (S) (x S))))

  (define input
    '())

  (define expected
    (parselynn:lr-reject-action:make))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Self referential grammar [3].
  ;;
  ;;   Grammar:
  ;;
  ;; S -> S
  ;; S -> x S
  ;;

  (define grammar
    '((S (S) (x S))))

  (define input
    '(b))

  (define expected
    (parselynn:lr-reject-action:make))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Start issue grammar [2].
  ;;
  ;;   Grammar:
  ;;
  ;; S -> a
  ;; S -> S b
  ;;

  (define grammar
    '((S (a) (S b))))

  (define input
    '(b))

  (define expected
    (parselynn:lr-reject-action:make))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Start issue grammar [2].
  ;;
  ;;   Grammar:
  ;;
  ;; S -> a
  ;; S -> S b
  ;;

  (define grammar
    '((S (a) (S b))))

  (define input
    `(a))

  (define expected
    `(S (a)))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Start issue grammar [2].
  ;;
  ;;   Grammar:
  ;;
  ;; S -> a
  ;; S -> S b
  ;;

  (define grammar
    '((S (a) (S b))))

  (define input
    `(a b))

  (define expected
    `(S ((S (a)) b)))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Start issue grammar [2].
  ;;
  ;;   Grammar:
  ;;
  ;; S -> a
  ;; S -> S b
  ;;

  (define grammar
    '((S (a) (S b))))

  (define input
    `(a a b))

  (define expected
    (parselynn:lr-reject-action:make))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Start issue grammar [2].
  ;;
  ;;   Grammar:
  ;;
  ;; S -> a
  ;; S -> S b
  ;;

  (define grammar
    '((S (a) (S b))))

  (define input
    `(a b b))

  (define expected
    `(S ((S ((S (a)) b)) b)))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Start issue grammar [2].
  ;;
  ;;   Grammar:
  ;;
  ;; S -> a
  ;; S -> S b
  ;;

  (define grammar
    '((S (a) (S b))))

  (define input
    `(a b b b b b))

  (define expected
    `(S ((S ((S ((S ((S ((S (a)) b)) b)) b)) b)) b)))

  (test-case grammar input expected))
