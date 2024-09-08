
(define-syntax test-follow
  (syntax-rules ()
    ((_ grammar expected-follow)
     (let ()
       (define computed-follow
         (hashmap->alist
          (bnf-alist:compute-follow-set grammar)))

       (assert=HS
        (map car expected-follow)
        (map car computed-follow))

       (for-each
        (lambda (nt)
          (let ((expected (assoc-or nt expected-follow))
                (computed (hashset->list (assoc-or nt computed-follow))))
            (assert=HS expected computed)))
        (map car expected-follow))))))



(define epsilon parselynn:epsilon)
(define end-of-input parselynn:end-of-input)


;;;;;;;;;;;;;;;;;;
;;
;; Test cases:
;;


;; Adapt the empty grammar test case for FOLLOW
(let ()
  ;;
  ;; Empty grammar.
  ;;

  (define grammar
    '())

  (define expected-follow
    `())

  (test-follow grammar expected-follow))


(let ()
  ;;
  ;; Grammar with single production.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> a
  ;;
  ;;   Expected FOLLOW sets:
  ;;
  ;; FOLLOW(S) = { $ }  ;; Start symbol gets end-of-input marker
  ;;

  (define grammar
    '((S (a))))

  (define expected-follow
    `((S ,end-of-input)))

  (test-follow grammar expected-follow))


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
  ;;   Expected FOLLOW sets:
  ;;
  ;; FOLLOW(S) = { $ }   ;; Start symbol gets end-of-input marker
  ;; FOLLOW(A) = { c }   ;; A is followed by B which starts with c
  ;; FOLLOW(B) = { e }   ;; B is followed by e
  ;;

  (define grammar
    '((S (A B e))
      (A (a b))
      (B (c d))))

  (define expected-follow
    `((S ,end-of-input)
      (A c)
      (B e)))

  (test-follow grammar expected-follow))


(let ()
  ;;
  ;; Simple grammar with single non-terminal.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> a S b
  ;; S -> epsilon
  ;;
  ;;   Expected FOLLOW sets:
  ;;
  ;; FOLLOW(S) = { b, $ } ;; S is followed by b or nothing (end-of-input)
  ;;

  (define grammar
    '((S (a S b) ())))

  (define expected-follow
    `((S b ,end-of-input)))

  (test-follow grammar expected-follow))


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
  ;;   Expected FOLLOW sets:
  ;;
  ;; FOLLOW(S) = { $ }
  ;; FOLLOW(A) = { c }
  ;; FOLLOW(B) = { e, m }
  ;;

  (define grammar
    '((S (A B e) (B m))
      (A (a b))
      (B (c d))))

  (define expected-follow
    `((S ,end-of-input)
      (A c)
      (B e m)))

  (test-follow grammar expected-follow))


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
  ;;   Expected FOLLOW sets:
  ;;
  ;; FOLLOW(S) = { $ }
  ;; FOLLOW(A) = { c, d }
  ;; FOLLOW(B) = { $ }
  ;;

  (define grammar
    '((S (A B))
      (A (a A) (b))
      (B (c B) (d))))

  (define expected-follow
    `((S ,end-of-input)
      (A c d)
      (B ,end-of-input)))

  (test-follow grammar expected-follow))


(let ()
  ;;
  ;; Simple grammar with multiple non-terminals.
  ;;
  ;;   Grammar:
  ;;
  ;; E  -> T E'
  ;; E' -> + T E'
  ;; E' -> epsilon
  ;; T  -> F T'
  ;; T' -> * F T'
  ;; T' -> epsilon
  ;; F  -> id
  ;;
  ;;   Expected FOLLOW sets:
  ;;
  ;; FOLLOW(E)  = { $ }
  ;; FOLLOW(E') = { $ }
  ;; FOLLOW(T)  = { +, $ }
  ;; FOLLOW(T') = { +, $ }
  ;; FOLLOW(F)  = { *, +, $ }
  ;;

  (define grammar
    '((E (T E'))
      (E' (+ T E') ())
      (T (F T'))
      (T' (* F T') ())
      (F (id))))

  (define expected-follow
    `((E ,end-of-input)
      (E' ,end-of-input)
      (T + ,end-of-input)
      (T' + ,end-of-input)
      (F * + ,end-of-input)))

  (test-follow grammar expected-follow))


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
  ;;   Expected FOLLOW sets:
  ;;
  ;; FOLLOW(S) = { $ }
  ;; FOLLOW(A) = { b, $ }
  ;; FOLLOW(B) = { $ }
  ;;

  (define grammar
    '((S (A B))
      (A (a) ())
      (B (b) ())))

  (define expected-follow
    `((S ,end-of-input)
      (A b ,end-of-input)
      (B ,end-of-input)))

  (test-follow grammar expected-follow))


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
  ;;   Expected FOLLOW sets:
  ;;
  ;; FOLLOW(S) = { $ }
  ;; FOLLOW(A) = { $ }
  ;; FOLLOW(B) = { $ }
  ;;

  (define grammar
    '((S (A) (B))
      (A (a A) (a))
      (B (b B) (b))))

  (define expected-follow
    `((S ,end-of-input)
      (A ,end-of-input)
      (B ,end-of-input)))

  (test-follow grammar expected-follow))


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
  ;;   Expected FOLLOW sets:
  ;;
  ;; FOLLOW(S) = { $ }
  ;; FOLLOW(A) = { c, $ }
  ;; FOLLOW(B) = { $ }
  ;;

  (define grammar
    '((S (A B) (b))
      (A (a) ())
      (B (c B) ())))

  (define expected-follow
    `((S ,end-of-input)
      (A c ,end-of-input)
      (B ,end-of-input)))

  (test-follow grammar expected-follow))


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
  ;;   Expected FOLLOW sets:
  ;;
  ;; FOLLOW(S) = { $ }
  ;; FOLLOW(A) = { b, c }
  ;; FOLLOW(B) = { $ }
  ;;

  (define grammar
    '((S (A B))
      (A (a A) ())
      (B (b B) (c))))

  (define expected-follow
    `((S ,end-of-input)
      (A b c)
      (B ,end-of-input)))

  (test-follow grammar expected-follow))


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
  ;;   Expected FOLLOW sets:
  ;;
  ;; FOLLOW(S) = { $ }
  ;; FOLLOW(A) = { c, b }
  ;; FOLLOW(B) = { $ }
  ;; FOLLOW(C) = { $ }
  ;;

  (define grammar
    '((S (A C))
      (A (a) ())
      (B (b B) (b))
      (C (c) (B))))

  (define expected-follow
    `((S ,end-of-input)
      (A c b)
      (B ,end-of-input)
      (C ,end-of-input)))

  (test-follow grammar expected-follow))


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
  ;;   Expected FOLLOW sets:
  ;;
  ;; FOLLOW(S) = { $ }
  ;; FOLLOW(A) = { $ }
  ;; FOLLOW(B) = { $ }
  ;; FOLLOW(C) = { $ }
  ;;

  (define grammar
    '((S (A))
      (A (B))
      (B (C))
      (C (a C) ())))

  (define expected-follow
    `((S ,end-of-input)
      (A ,end-of-input)
      (B ,end-of-input)
      (C ,end-of-input)))

  (test-follow grammar expected-follow))


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
  ;;   Expected FOLLOW sets:
  ;;
  ;; FOLLOW(S) = { $ }
  ;; FOLLOW(E) = { $, r }
  ;; FOLLOW(T) = { $, r, + }
  ;;

  (define grammar
    '((S (E))
      (E (T) (l E r))
      (T (n) (+ T) (T + n))))

  (define expected-follow
    `((S ,end-of-input)
      (E ,end-of-input r)
      (T ,end-of-input r +)))

  (test-follow grammar expected-follow))


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
  ;;   Expected FOLLOW sets:
  ;;
  ;; FOLLOW(A) = { $ }
  ;; FOLLOW(B) = { $ }
  ;; FOLLOW(C) = { $ }
  ;;

  (define grammar
    '((A (B))
      (B (C))
      (C (A) (a) ())))

  (define expected-follow
    `((A ,end-of-input)
      (B ,end-of-input)
      (C ,end-of-input)))

  (test-follow grammar expected-follow))


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
  ;;   Expected FOLLOW sets:
  ;;
  ;; FOLLOW(S) = { $ }
  ;; FOLLOW(A) = { a, b, $ }
  ;; FOLLOW(B) = { $ }
  ;;

  (define grammar
    '((S (A B))
      (A (a) ())
      (B (b) () (A))))

  (define expected-follow
    `((S ,end-of-input)
      (A a b ,end-of-input)
      (B ,end-of-input)))

  (test-follow grammar expected-follow))


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
  ;;   Expected FOLLOW sets:
  ;;
  ;; FOLLOW(S) = { $ }
  ;; FOLLOW(A) = { b, d, $ }
  ;; FOLLOW(B) = { $ }
  ;; FOLLOW(C) = { $ }
  ;;

  (define grammar
    '((S (A B) (C))
      (A (a) ())
      (B (b B) (d) ())
      (C (c) (B))))

  (define expected-follow
    `((S ,end-of-input)
      (A b d ,end-of-input)
      (B ,end-of-input)
      (C ,end-of-input)))

  (test-follow grammar expected-follow))


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
  ;;   Expected FOLLOW sets:
  ;;
  ;; FOLLOW(S) = { $ }
  ;; FOLLOW(A) = { $ }
  ;; FOLLOW(B) = { $ }
  ;; FOLLOW(C) = { $ }
  ;;

  (define grammar
    '((S (A))
      (A (B))
      (B (C))
      (C ())))

  (define expected-follow
    `((S ,end-of-input)
      (A ,end-of-input)
      (B ,end-of-input)
      (C ,end-of-input)))

  (test-follow grammar expected-follow))


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
  ;;   Expected FOLLOW sets:
  ;;
  ;; FOLLOW(S) = { $ }
  ;; FOLLOW(A) = { $ }
  ;; FOLLOW(B) = { $ }
  ;; FOLLOW(C) = { $ }
  ;;

  (define grammar
    '((S (A))
      (A (B))
      (B (C))
      (C (S) (a))))

  (define expected-follow
    `((S ,end-of-input)
      (A ,end-of-input)
      (B ,end-of-input)
      (C ,end-of-input)))

  (test-follow grammar expected-follow))


(let ()
  ;;
  ;; Grammar with deep epsilon recursion and terminal at the end.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A A A a
  ;; A -> epsilon
  ;;
  ;;   Expected FOLLOW sets:
  ;;
  ;; FOLLOW(S) = { $ }
  ;; FOLLOW(A) = { a }
  ;;

  (define grammar
    '((S (A A A a))
      (A ())))

  (define expected-follow
    `((S ,end-of-input)
      (A a)))

  (test-follow grammar expected-follow))


(let ()
  ;;
  ;; Grammar with epsilon cycles and terminals.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A B c
  ;; A -> epsilon
  ;; B -> epsilon
  ;; C -> B d
  ;;
  ;;   Expected FOLLOW sets:
  ;;
  ;; FOLLOW(S) = { $ }
  ;; FOLLOW(A) = { c }
  ;; FOLLOW(B) = { d, c }
  ;; FOLLOW(C) = {}
  ;;
  (define grammar
    '((S (A B c))
      (A ())
      (B ())
      (C (B d))))

  (define expected-follow
    `((S ,end-of-input)
      (A c)
      (B d c)
      (C)))

  (test-follow grammar expected-follow))


(let ()
  ;;
  ;; Grammar where derivation depends on epsilon-unreachable production.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> A
  ;; A -> B
  ;; B -> C
  ;; C -> D
  ;; D -> e
  ;;
  ;;   Expected FOLLOW sets:
  ;;
  ;; FOLLOW(S) = { $ }
  ;; FOLLOW(A) = { $ }
  ;; FOLLOW(B) = { $ }
  ;; FOLLOW(C) = { $ }
  ;; FOLLOW(D) = { $ }
  ;;

  (define grammar
    '((S (A))
      (A (B))
      (B (C))
      (C (D))
      (D (e))))

  (define expected-follow
    `((S ,end-of-input)
      (A ,end-of-input)
      (B ,end-of-input)
      (C ,end-of-input)
      (D ,end-of-input)))

  (test-follow grammar expected-follow))


(let ()
  ;;
  ;; Grammar with circular epsilon dependencies.
  ;;
  ;;   Grammar:
  ;;
  ;; A -> B
  ;; B -> C
  ;; C -> A
  ;; C -> epsilon
  ;;
  ;;   Expected FOLLOW sets:
  ;;
  ;; FOLLOW(A) = { $ }
  ;; FOLLOW(B) = { $ }
  ;; FOLLOW(C) = { $ }
  ;;

  (define grammar
    '((A (B))
      (B (C))
      (C (A) ())))

  (define expected-follow
    `((A ,end-of-input)
      (B ,end-of-input)
      (C ,end-of-input)))

  (test-follow grammar expected-follow))


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
  ;; E -> epsilon
  ;; E -> f
  ;; F -> g
  ;;
  ;;   Expected FOLLOW sets:
  ;;
  ;; FOLLOW(S) = { $ }
  ;; FOLLOW(A) = { $ }
  ;; FOLLOW(B) = { $ }
  ;; FOLLOW(C) = { $ }
  ;; FOLLOW(D) = { $ }
  ;; FOLLOW(E) = { $ }
  ;; FOLLOW(F) = {}
  ;;

  (define grammar
    '((S (A))
      (A (B))
      (B (C))
      (C (D))
      (D (E))
      (E () (f))
      (F (g))))

  (define expected-follow
    `((S ,end-of-input)
      (A ,end-of-input)
      (B ,end-of-input)
      (C ,end-of-input)
      (D ,end-of-input)
      (E ,end-of-input)
      (F)))

  (test-follow grammar expected-follow))
