
(define-syntax test-first
  (syntax-rules ()
    ((_ grammar expected-first)
     (let ()
       (define computed-first
         (hashmap->alist
          (bnf-alist:calculate-first-set grammar)))

       (assert=HS
        (map car expected-first)
        (map car computed-first))

       (for-each

        (lambda (nt)
          (let ((expected (assoc-or nt expected-first))
                (computed (hashset->list (assoc-or nt computed-first))))
            (assert=HS expected computed)))

        (map car expected-first))))))


(define epsilon
  (string->symbol ""))


;;;;;;;;;;;;;;;;;;
;;
;; Test cases:
;;


(let ()
  ;;
  ;; Empty grammar.
  ;;

  (define grammar
    '())

  (define expected-first
    `())

  (test-first grammar expected-first))


(let ()
  ;;
  ;; Grammar with single production.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> a
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a }
  ;;

  (define grammar
    '((S (a))))

  (define expected-first
    `((S a)))

  (test-first grammar expected-first))


(let ()
  ;;
  ;; Grammar with single 1-recursive production.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> S
  ;; S -> a
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a }
  ;;

  (define grammar
    '((S (S) (a))))

  (define expected-first
    `((S a)))

  (test-first grammar expected-first))


(let ()
  ;;
  ;; Grammar with multiple productions.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A B e
  ;; A -> a b
  ;; B -> c d
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a }
  ;; FIRST(A) = { a }
  ;; FIRST(B) = { c }
  ;;

  (define grammar
    '((S (A B e))
      (A (a b))
      (B (c d))))

  (define expected-first
    `((S a)
      (A a)
      (B c)))

  (test-first grammar expected-first))


(let ()
  ;;
  ;; Grammar with multiple productions and alternatives.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A B e
  ;; S -> B m
  ;; A -> a b
  ;; B -> c d
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a, c }
  ;; FIRST(A) = { a }
  ;; FIRST(B) = { c }
  ;;

  (define grammar
    '((S (A B e) (B m))
      (A (a b))
      (B (c d))))

  (define expected-first
    `((S a c)
      (A a)
      (B c)))

  (test-first grammar expected-first))


(let ()
  ;;
  ;; 1-Recrusive grammar with no epsilon production.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A B
  ;; A -> a A
  ;; A -> b
  ;; B -> c B
  ;; B -> d
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a, b }
  ;; FIRST(A) = { a, b }
  ;; FIRST(B) = { c, d }
  ;;

  (define grammar
    '((S (A B))
      (A (a A) (b))
      (B (c B) (d))))

  (define expected-first
    `((S a b)
      (A a b)
      (B c d)))

  (test-first grammar expected-first))


(let ()
  ;;
  ;; Simple grammar with single non-terminal.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> a S b
  ;; S -> epsilon
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a, epsilon }
  ;;

  (define grammar
    '((S (a S b) ())))

  (define expected-first
    `((S a ,epsilon)))

  (test-first grammar expected-first))


(let ()
  ;;
  ;; Simple grammar with multiple non-terminals.
  ;;
  ;;   Grammar:
  ;; E  -> T E'
  ;; E' -> + T E'
  ;; E' -> epsilon
  ;; T  -> F T'
  ;; T' -> * F T'
  ;; T' -> epsilon
  ;; F  -> id
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(E)  = { id }
  ;; FIRST(E') = { +, epsilon }
  ;; FIRST(T)  = { id }
  ;; FIRST(T') = { *, epsilon }
  ;; FIRST(F)  = { id }
  ;;

  (define grammar
    '((E (T E'))
      (E' (+ T E') ())
      (T (F T'))
      (T' (* F T') ())
      (F (id))))

  (define expected-first
    `((E id)
      (E' + ,epsilon)
      (T id)
      (T' * ,epsilon)
      (F id)))

  (test-first grammar expected-first))


(let ()
  ;;
  ;; Grammar with multiple non-terminals sharing production.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A B
  ;; A -> a
  ;; A -> epsilon
  ;; B -> b
  ;; B -> epsilon
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a, b, epsilon }
  ;; FIRST(A) = { a, epsilon }
  ;; FIRST(B) = { b, epsilon }
  ;;

  (define grammar
    '((S (A B))
      (A (a) ())
      (B (b) ())))

  (define expected-first
    `((S a b ,epsilon)
      (A a ,epsilon)
      (B b ,epsilon)))

  (test-first grammar expected-first))


(let ()
  ;;
  ;; Simple recursive grammar with non-epsilon productions.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A
  ;; S -> B
  ;; A -> a A
  ;; A -> a
  ;; B -> b B
  ;; B -> b
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a, b }
  ;; FIRST(A) = { a }
  ;; FIRST(B) = { b }
  ;;

  (define grammar
    '((S (A) (B))
      (A (a A) (a))
      (B (b B) (b))))

  (define expected-first
    `((S a b)
      (A a)
      (B b)))

  (test-first grammar expected-first))


(let ()
  ;;
  ;; Complex grammar with multiple productions
  ;; including terminals and non-terminals.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A B
  ;; S -> b
  ;; A -> a
  ;; A -> epsilon
  ;; B -> c B
  ;; B -> epsilon
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a, b, c, epsilon }
  ;; FIRST(A) = { a, epsilon }
  ;; FIRST(B) = { c, epsilon }
  ;;

  (define grammar
    '((S (A B) (b))
      (A (a) ())
      (B (c B) ())))

  (define expected-first
    `((S a b c ,epsilon)
      (A a ,epsilon)
      (B c ,epsilon)))

  (test-first grammar expected-first))


(let ()
  ;;
  ;; Complex grammar with mixed epsilon and terminal derivations.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A B
  ;; A -> a A
  ;; A -> epsilon
  ;; B -> b B
  ;; B -> c
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a, b, c }
  ;; FIRST(A) = { a, epsilon }
  ;; FIRST(B) = { b, c }
  ;;

  (define grammar
    '((S (A B))
      (A (a A) ())
      (B (b B) (c))))

  (define expected-first
    `((S a b c)
      (A a ,epsilon)
      (B b c)))

  (test-first grammar expected-first))


(let ()
  ;;
  ;; Grammar with tricky epsilon derivation.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A C
  ;; A -> a
  ;; A -> epsilon
  ;; B -> b B
  ;; B -> b
  ;; C -> c
  ;; C -> B
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a, b, c }
  ;; FIRST(A) = { a, epsilon }
  ;; FIRST(B) = { b }
  ;; FIRST(C) = { c, b }
  ;;

  (define grammar
    '((S (A C))
      (A (a) ())
      (B (b B) (b))
      (C (c) (B))))

  (define expected-first
    `((S a b c)
      (A a ,epsilon)
      (B b)
      (C c b)))

  (test-first grammar expected-first))


(let ()
  ;;
  ;; Grammar with indirect left recursion.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A
  ;; A -> B
  ;; B -> C
  ;; C -> a C
  ;; C -> epsilon
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a, epsilon }
  ;; FIRST(A) = { a, epsilon }
  ;; FIRST(B) = { a, epsilon }
  ;; FIRST(C) = { a, epsilon }
  ;;

  (define grammar
    '((S (A))
      (A (B))
      (B (C))
      (C (a C) ())))

  (define expected-first
    `((S a ,epsilon)
      (A a ,epsilon)
      (B a ,epsilon)
      (C a ,epsilon)))

  (test-first grammar expected-first))


(let ()
  ;;
  ;; Wikipedia example.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> E
  ;; E -> T
  ;; E -> l E r
  ;; T -> n
  ;; T -> + T
  ;; T -> T + n
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { n, +, l }
  ;; FIRST(E) = { n, +, l }
  ;; FIRST(T) = { n, + }
  ;;

  (define grammar
    '((S (E))
      (E (T) (l E r))
      (T (n) (+ T) (T + n))))

  (define expected-first
    `((S n + l)
      (E n + l)
      (T n +)))

  (test-first grammar expected-first))


(let ()
  ;;
  ;; Grammar with mutual recursion.
  ;;
  ;;   Grammar:
  ;;
  ;; A -> B
  ;; B -> C
  ;; C -> A
  ;; C -> a
  ;; C -> epsilon
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(A) = { a, epsilon }
  ;; FIRST(B) = { a, epsilon }
  ;; FIRST(C) = { a, epsilon }
  ;;

  (define grammar
    '((A (B))
      (B (C))
      (C (A) (a) ())))

  (define expected-first
    `((A a ,epsilon)
      (B a ,epsilon)
      (C a ,epsilon)))

  (test-first grammar expected-first))


(let ()
  ;;
  ;; Grammar with indirect epsilon derivation.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A B
  ;; A -> a
  ;; A -> epsilon
  ;; B -> b
  ;; B -> epsilon
  ;; B -> A
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a, b, epsilon }
  ;; FIRST(A) = { a, epsilon }
  ;; FIRST(B) = { b, a, epsilon }
  ;;

  (define grammar
    '((S (A B))
      (A (a) ())
      (B (b) () (A))))

  (define expected-first
    `((S a b ,epsilon)
      (A a ,epsilon)
      (B b a ,epsilon)))

  (test-first grammar expected-first))


(let ()
  ;;
  ;; Grammar with more complex epsilon derivations and recursion.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A B
  ;; S -> C
  ;; A -> a
  ;; A -> epsilon
  ;; B -> b B
  ;; B -> d
  ;; B -> epsilon
  ;; C -> c
  ;; C -> B
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a, b, d, c, epsilon }
  ;; FIRST(A) = { a, epsilon }
  ;; FIRST(B) = { b, d, epsilon }
  ;; FIRST(C) = { c, b, d, epsilon }
  ;;

  (define grammar
    '((S (A B) (C))
      (A (a) ())
      (B (b B) (d) ())
      (C (c) (B))))

  (define expected-first
    `((S a b d c ,epsilon)
      (A a ,epsilon)
      (B b d ,epsilon)
      (C c b d ,epsilon)))

  (test-first grammar expected-first))


(let ()
  ;;
  ;; Grammar with epsilon leading to no terminal derivation.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A
  ;; A -> B
  ;; B -> C
  ;; C -> epsilon
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { epsilon }
  ;; FIRST(A) = { epsilon }
  ;; FIRST(B) = { epsilon }
  ;; FIRST(C) = { epsilon }
  ;;

  (define grammar
    '((S (A))
      (A (B))
      (B (C))
      (C ())))

  (define expected-first
    `((S ,epsilon)
      (A ,epsilon)
      (B ,epsilon)
      (C ,epsilon)))

  (test-first grammar expected-first))


(let ()
  ;;
  ;; Grammar with chain of non-terminals pointing back to self.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A
  ;; A -> B
  ;; B -> C
  ;; C -> S
  ;; C -> a
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a }
  ;; FIRST(A) = { a }
  ;; FIRST(B) = { a }
  ;; FIRST(C) = { a }
  ;;

  (define grammar
    '((S (A))
      (A (B))
      (B (C))
      (C (S) (a))))

  (define expected-first
    `((S a)
      (A a)
      (B a)
      (C a)))

  (test-first grammar expected-first))
