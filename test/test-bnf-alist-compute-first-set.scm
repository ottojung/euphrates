
(define-syntax test-first
  (syntax-rules ()
    ((_ grammar expected-first)
     (let ()
       (define computed-first
         (hashmap->alist
          (bnf-alist:compute-first-set grammar)))

       (assert=HS
        (map car expected-first)
        (map car computed-first))

       (for-each

        (lambda (nt)
          (let ((expected (assoc-or nt expected-first))
                (computed (hashset->list (assoc-or nt computed-first))))
            (assert=HS expected computed)))

        (map car expected-first))))))


(define epsilon "")


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
  ;; Grammar with single empty production.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> ε
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { ε }
  ;;

  (define grammar
    '((S ())))

  (define expected-first
    `((S ,epsilon)))

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
  ;; S -> ε
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a, ε }
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
  ;; E' -> ε
  ;; T  -> F T'
  ;; T' -> * F T'
  ;; T' -> ε
  ;; F  -> id
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(E)  = { id }
  ;; FIRST(E') = { +, ε }
  ;; FIRST(T)  = { id }
  ;; FIRST(T') = { *, ε }
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
  ;; A -> ε
  ;; B -> b
  ;; B -> ε
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a, b, ε }
  ;; FIRST(A) = { a, ε }
  ;; FIRST(B) = { b, ε }
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
  ;; Simple recursive grammar with non-ε productions.
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
  ;; A -> ε
  ;; B -> c B
  ;; B -> ε
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a, b, c, ε }
  ;; FIRST(A) = { a, ε }
  ;; FIRST(B) = { c, ε }
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
  ;; Complex grammar with mixed ε and terminal derivations.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A B
  ;; A -> a A
  ;; A -> ε
  ;; B -> b B
  ;; B -> c
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a, b, c }
  ;; FIRST(A) = { a, ε }
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
  ;; Grammar with tricky ε derivation.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A C
  ;; A -> a
  ;; A -> ε
  ;; B -> b B
  ;; B -> b
  ;; C -> c
  ;; C -> B
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a, b, c }
  ;; FIRST(A) = { a, ε }
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
  ;; C -> ε
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a, ε }
  ;; FIRST(A) = { a, ε }
  ;; FIRST(B) = { a, ε }
  ;; FIRST(C) = { a, ε }
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
  ;; C -> ε
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(A) = { a, ε }
  ;; FIRST(B) = { a, ε }
  ;; FIRST(C) = { a, ε }
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
  ;; Grammar with indirect ε derivation.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A B
  ;; A -> a
  ;; A -> ε
  ;; B -> b
  ;; B -> ε
  ;; B -> A
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a, b, ε }
  ;; FIRST(A) = { a, ε }
  ;; FIRST(B) = { b, a, ε }
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
  ;; Grammar with more complex ε derivations and recursion.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A B
  ;; S -> C
  ;; A -> a
  ;; A -> ε
  ;; B -> b B
  ;; B -> d
  ;; B -> ε
  ;; C -> c
  ;; C -> B
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a, b, d, c, ε }
  ;; FIRST(A) = { a, ε }
  ;; FIRST(B) = { b, d, ε }
  ;; FIRST(C) = { c, b, d, ε }
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
  ;; Grammar with ε leading to no terminal derivation.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A
  ;; A -> B
  ;; B -> C
  ;; C -> ε
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { ε }
  ;; FIRST(A) = { ε }
  ;; FIRST(B) = { ε }
  ;; FIRST(C) = { ε }
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


(let ()
  ;;
  ;; Grammar with deep ε recursion and terminal at the end.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A A A a
  ;; A -> ε
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { a }
  ;; FIRST(A) = { ε }
  ;;

  (define grammar
    '((S (A A A a))
      (A ())))

  (define expected-first
    `((S a)
      (A ,epsilon)))

  (test-first grammar expected-first))


(let ()
  ;;
  ;; Grammar with ε cycles and terminals.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A B c
  ;; A -> ε
  ;; B -> ε
  ;; C -> B d
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { c }
  ;; FIRST(A) = { ε }
  ;; FIRST(B) = { ε }
  ;; FIRST(C) = { d, ε }
  ;;
  (define grammar
    '((S (A B c))
      (A ())
      (B ())
      (C (B d))))

  (define expected-first
    `((S c)
      (A ,epsilon)
      (B ,epsilon)
      (C d)))

  (test-first grammar expected-first))


(let ()
  ;;
  ;; Grammar where derivation depends on ε-unreachable production.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A
  ;; A -> B
  ;; B -> C
  ;; C -> D
  ;; D -> e
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { e }
  ;; FIRST(A) = { e }
  ;; FIRST(B) = { e }
  ;; FIRST(C) = { e }
  ;; FIRST(D) = { e }
  ;;

  (define grammar
    '((S (A))
      (A (B))
      (B (C))
      (C (D))
      (D (e))))

  (define expected-first
    `((S e)
      (A e)
      (B e)
      (C e)
      (D e)))

  (test-first grammar expected-first))


(let ()
  ;;
  ;; Grammar with circular ε dependencies.
  ;;
  ;;   Grammar:
  ;;
  ;; A -> B
  ;; B -> C
  ;; C -> A
  ;; C -> ε
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(A) = { ε }
  ;; FIRST(B) = { ε }
  ;; FIRST(C) = { ε }
  ;;

  (define grammar
    '((A (B))
      (B (C))
      (C (A) ())))

  (define expected-first
    `((A ,epsilon)
      (B ,epsilon)
      (C ,epsilon)))

  (test-first grammar expected-first))


(let ()
  ;;
  ;; Grammar with deep recursion.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A
  ;; A -> B
  ;; B -> C
  ;; C -> D
  ;; D -> E
  ;; E -> ε
  ;; E -> f
  ;; F -> g
  ;;
  ;;   Expected FIRST sets:
  ;;
  ;; FIRST(S) = { ε, f }
  ;; FIRST(A) = { ε, f }
  ;; FIRST(B) = { ε, f }
  ;; FIRST(C) = { ε, f }
  ;; FIRST(D) = { ε, f }
  ;; FIRST(E) = { ε, f }
  ;; FIRST(F) = { g }
  ;;

  (define grammar
    '((S (A))
      (A (B))
      (B (C))
      (C (D))
      (D (E))
      (E () (f))
      (F (g))))

  (define expected-first
    `((S ,epsilon f)
      (A ,epsilon f)
      (B ,epsilon f)
      (C ,epsilon f)
      (D ,epsilon f)
      (E ,epsilon f)
      (F g)))

  (test-first grammar expected-first))
