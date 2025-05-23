
;;
;; Define test-case syntax.
;;

(define callback-alist/p
  (make-parameter '()))

(define-syntax test-case
  (syntax-rules ()
    ((_ grammar* input* expected*)
     (let ()
       (define grammar grammar*)
       (define input input*)
       (define expected expected*)
       (define callback-alist (callback-alist/p))
       (define error-procedure
         (lambda args
           (unless (parselynn:ll-reject-action? expected)
             (raisu 'error-called-16263 args))))

       (define table
         (parselynn:ll-compute-parsing-table grammar))

       (define (make-token category)
         (define source 'no-source)
         (define value category)
         (parselynn:token:make category source value))

       (define input-iterator
         (list->iterator (map make-token input)))

       (define result
         ((parselynn:ll-interpret table callback-alist)
          input-iterator error-procedure))

       (define to-compare
         (if (equal? #f result)
             (parselynn:ll-reject-action:make)
             result))

       (unless (equal? to-compare expected)
         (debug "\n\n\n----------------------------------\nactual:\n~s\n\n" result))

       (assert= to-compare expected)))))


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
    (parselynn:ll-reject-action:make))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Simple arithmetic expression grammar.
  ;;
  ;;   Grammar:
  ;;
  ;; E -> T
  ;; E -> < E >
  ;; E -> + T E
  ;; E -> * T E
  ;; T -> x | y | z
  ;;

  (define grammar
    `((E (T) (< E >) (+ T E) (* T E))
      (T (x) (y) (z))))

  (define input
    `(+ x y))

  (define expected
    `(E + (T x) (E (T y))))

  (test-case grammar input expected))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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
    (parselynn:ll-reject-action:make))

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
    (parselynn:ll-reject-action:make))

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
    (parselynn:ll-reject-action:make))

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
    (parselynn:ll-reject-action:make))

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
    `(S))

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
    (parselynn:ll-reject-action:make))

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
    '(S a))

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
    (parselynn:ll-reject-action:make))

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
    (parselynn:ll-reject-action:make))

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
    `(S a b))

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
    `(S a b c))

  (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Self referential grammar [2].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> S
;;   ;; S -> x
;;   ;;

;;   (define grammar
;;     '((S (S) (x))))

;;   (define input
;;     '(x))

;;   (define expected
;;     `(S x))

;;   (assert-throw
;;    'parse-conflict
;;    (test-case grammar input expected)))


;; (let ()
;;   ;;
;;   ;; Self referential grammar [2].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> x
;;   ;; S -> S
;;   ;;

;;   (define grammar
;;     '((S (x) (S))))

;;   (define input
;;     '(x))

;;   (define expected
;;     `(S x))

;;   (assert-throw
;;    'parse-conflict
;;    (test-case grammar input expected)))


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
    (parselynn:ll-reject-action:make))

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
    `(S (E a)))

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
    `(S (E a b)))

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
    `(S (E a) b))

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
    `(S (E a b) c))

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
    `(S (E a b) (E a b)))

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
    `(S (E a b) (E a b)))

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
    `(S (E a b) (E a b) (E a b)))

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
    `(S (E a b) c))

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
    `(S (E) c))

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
    `(S (E a b) c))

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
    `(S a))

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
    `(S b))

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
    `(S c))

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
    (parselynn:ll-reject-action:make))

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
    (cons 'S input))

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
    (cons 'S input))

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
    (cons 'S input))

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
    (cons 'S input))

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
    (cons 'S input))

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
    (parselynn:ll-reject-action:make))

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
    `(S (A a) (B b)))

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
    (parselynn:ll-reject-action:make))

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
    (parselynn:ll-reject-action:make))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Self referential grammar [3].
  ;;
  ;;   Grammar:
  ;;
  ;; S -> x S
  ;; S -> S
  ;;

  (define grammar
    '((S (x S) (S))))

  (define input
    '(x))

  (define expected
    (parselynn:ll-reject-action:make))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Self referential grammar [3].
  ;;
  ;;   Grammar:
  ;;
  ;; S -> x S
  ;; S -> S
  ;;

  (define grammar
    '((S (x S) (S))))

  (define input
    '(x x))

  (define expected
    (parselynn:ll-reject-action:make))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Self referential grammar [3].
  ;;
  ;;   Grammar:
  ;;
  ;; S -> x S
  ;; S -> S
  ;;

  (define grammar
    '((S (x S) (S))))

  (define input
    '())

  (define expected
    (parselynn:ll-reject-action:make))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Self referential grammar [3].
  ;;
  ;;   Grammar:
  ;;
  ;; S -> x S
  ;; S -> S
  ;;

  (define grammar
    '((S (x S) (S))))

  (define input
    '(b))

  (define expected
    (parselynn:ll-reject-action:make))

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
    (parselynn:ll-reject-action:make))

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
    `(S a))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Start issue grammar [2].
  ;;
  ;;   Grammar:
  ;;
  ;; S -> a S
  ;; S -> b
  ;;

  (define grammar
    '((S (a S) (b))))

  (define input
    `(a b))

  (define expected
    `(S a (S b)))

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
    (parselynn:ll-reject-action:make))

  (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Start issue grammar [2].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> a
;;   ;; S -> S b
;;   ;;

;;   (define grammar
;;     '((S (a) (S b))))

;;   (define input
;;     `(a b b))

;;   (define expected
;;     `(S (S (S a) b) b))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Start issue grammar [2].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> a
;;   ;; S -> S b
;;   ;;

;;   (define grammar
;;     '((S (a) (S b))))

;;   (define input
;;     `(a b b b b b))

;;   (define expected
;;     `(S (S (S (S (S (S a) b) b) b) b) b))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Start issue grammar [2].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> a
;;   ;; S -> S b
;;   ;;

;;   (define grammar
;;     '((S (a) (S b))))

;;   (define input
;;     `(b))

;;   (define expected
;;     (parselynn:ll-reject-action:make))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Start issue grammar [2].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> a
;;   ;; S -> S b
;;   ;;

;;   (define grammar
;;     '((S (a) (S b))))

;;   (define input
;;     `(a b b b a))

;;   (define expected
;;     (parselynn:ll-reject-action:make))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Start issue grammar [2].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> a
;;   ;; S -> S b
;;   ;;

;;   (define grammar
;;     '((S (a) (S b))))

;;   (define input
;;     `(a b b b x))

;;   (define expected
;;     (parselynn:ll-reject-action:make))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Start issue grammar [3].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> a
;;   ;; S -> b S
;;   ;;

;;   (define grammar
;;     '((S (a) (b S))))

;;   (define input
;;     `(a))

;;   (define expected
;;     `(S a))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Start issue grammar [3].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> a
;;   ;; S -> b S
;;   ;;

;;   (define grammar
;;     '((S (a) (b S))))

;;   (define input
;;     `(b a))

;;   (define expected
;;     `(S b (S a)))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Start issue grammar [3].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> a
;;   ;; S -> b S
;;   ;;

;;   (define grammar
;;     '((S (a) (b S))))

;;   (define input
;;     `(b b b b a))

;;   (define expected
;;     `(S b (S b (S b (S b (S a))))))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Start issue grammar [3].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> a
;;   ;; S -> b S
;;   ;;

;;   (define grammar
;;     '((S (a) (b S))))

;;   (define input
;;     `(b b b b a b))

;;   (define expected
;;     (parselynn:ll-reject-action:make))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Start issue grammar [3].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> a
;;   ;; S -> b S
;;   ;;

;;   (define grammar
;;     '((S (a) (b S))))

;;   (define input
;;     `(b b b b a a))

;;   (define expected
;;     (parselynn:ll-reject-action:make))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Start issue grammar [3].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> a
;;   ;; S -> b S
;;   ;;

;;   (define grammar
;;     '((S (a) (b S))))

;;   (define input
;;     `(b b b b a x))

;;   (define expected
;;     (parselynn:ll-reject-action:make))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Start issue grammar [3].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; G -> S
;;   ;; S -> a
;;   ;; S -> b S
;;   ;;

;;   (define grammar
;;     '((G (S)) (S (a) (b S))))

;;   (define input
;;     `(b b b b a))

;;   (define expected
;;     `(G (S b (S b (S b (S b (S a)))))))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Umich grammar (https://web.eecs.umich.edu/~weimerw/2009-4610/lectures/weimer-4610-09.pdf page 5).
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; E -> int
;;   ;; E -> E + ( E )
;;   ;;

;;   (define lb
;;     (string->symbol "("))

;;   (define rb
;;     (string->symbol ")"))

;;   (define grammar
;;     `((E (int)
;;          (E + ,lb E ,rb))))

;;   (define input
;;     `(int + ,lb int ,rb))

;;   (define expected
;;     `(E (E int) + ,lb (E int) ,rb))

;;   (test-case grammar input expected))


(let ()
  ;;
  ;; Umich grammar, modified. (https://web.eecs.umich.edu/~weimerw/2009-4610/lectures/weimer-4610-09.pdf page 5).
  ;;
  ;;   Grammar:
  ;;
  ;; E -> int C
  ;; C -> + ( E ) | epsilon
  ;;

  (define lb
    (string->symbol "("))

  (define rb
    (string->symbol ")"))

  (define grammar
    `((E (int C))
      (C (+ ,lb E ,rb) ())))

  (define input
    `(int + ,lb int ,rb))

  (define expected
    `(E int (C + ,lb (E int (C)) ,rb)))

  (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Umich grammar (https://web.eecs.umich.edu/~weimerw/2009-4610/lectures/weimer-4610-09.pdf page 5).
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; E -> int
;;   ;; E -> E + ( E )
;;   ;;

;;   (define lb
;;     (string->symbol "("))

;;   (define rb
;;     (string->symbol ")"))

;;   (define grammar
;;     `((E (int)
;;          (E + ,lb E ,rb))))

;;   (define input
;;     `(int))

;;   (define expected
;;     `(E int))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Umich grammar (https://web.eecs.umich.edu/~weimerw/2009-4610/lectures/weimer-4610-09.pdf page 5).
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; E -> int
;;   ;; E -> E + ( E )
;;   ;;

;;   (define lb
;;     (string->symbol "("))

;;   (define rb
;;     (string->symbol ")"))

;;   (define grammar
;;     `((E (int)
;;          (E + ,lb E ,rb))))

;;   (define input
;;     `(int + ,lb int + ,lb int ,rb ,rb))

;;   (define expected
;;     `(E (E int) + ,lb (E (E int) + ,lb (E int) ,rb) ,rb))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Clemson grammar (https://www.cs.clemson.edu/course/cpsc827/material/LLk/LL1.pdf page 3).
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; G -> S
;;   ;; S -> E = E
;;   ;;    | f
;;   ;; E -> T
;;   ;;    | E + T
;;   ;; T -> f
;;   ;;    | T * f
;;   ;;

;;   (define grammar
;;     `((G (S))
;;       (S (E = E)
;;          (f))
;;       (E (T)
;;          (E + T))
;;       (T (f)
;;          (T * f))))

;;   (define input
;;     `(f = f * f))

;;   (define expected
;;     `(G (S (E (T f)) = (E (T (T f) * f)))))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Modified Clemson grammar (https://www.cs.clemson.edu/course/cpsc827/material/LLk/LL1.pdf page 3).
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> E = E
;;   ;;    | f
;;   ;; E -> T
;;   ;;    | E + T
;;   ;; T -> f
;;   ;;    | T * f
;;   ;;

;;   (define grammar
;;     `((S (E = E)
;;          (f))
;;       (E (T)
;;          (E + T))
;;       (T (f)
;;          (T * f))))

;;   (define input
;;     `(f = f * f))

;;   (define expected
;;     `(S (E (T f)) = (E (T (T f) * f))))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Modified Clemson grammar (https://www.cs.clemson.edu/course/cpsc827/material/LLk/LL1.pdf page 3).
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> E = E
;;   ;;    | f
;;   ;; E -> T
;;   ;;    | E + T
;;   ;; T -> f
;;   ;;    | T * f
;;   ;;

;;   (define grammar
;;     `((S (E = E)
;;          (f))
;;       (E (T)
;;          (E + T))
;;       (T (f)
;;          (T * f))))

;;   (define input
;;     `(f + f = f * f))

;;   (define expected
;;     `(S (E (E (T f)) + (T f)) = (E (T (T f) * f))))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Modified Clemson grammar (https://www.cs.clemson.edu/course/cpsc827/material/LLk/LL1.pdf page 3).
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> E = E
;;   ;;    | f
;;   ;; E -> T
;;   ;;    | E + T
;;   ;; T -> f
;;   ;;    | T * f
;;   ;;

;;   (define grammar
;;     `((S (E = E)
;;          (f))
;;       (E (T)
;;          (E + T))
;;       (T (f)
;;          (T * f))))

;;   (define input
;;     `(f + f * f + f  = f * f))

;;   (define expected
;;     `(S (E (E (E (T f)) + (T (T f) * f)) + (T f)) = (E (T (T f) * f))))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Modified Clemson grammar (https://www.cs.clemson.edu/course/cpsc827/material/LLk/LL1.pdf page 3).
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> E = E
;;   ;;    | f
;;   ;; E -> T
;;   ;;    | E + T
;;   ;; T -> f
;;   ;;    | T * f
;;   ;;

;;   (define grammar
;;     `((S (E = E)
;;          (f))
;;       (E (T)
;;          (E + T))
;;       (T (f)
;;          (T * f))))

;;   (define input
;;     `(f + = f))

;;   (define expected
;;     (parselynn:ll-reject-action:make))

;;   (test-case grammar input expected))


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

  (define grammar
    '((S (X X))
      (X (a X)
         (b))))

  (define input
    `(a b a b))

  (define expected
    `(S (X a (X b)) (X a (X b))))

  (test-case grammar input expected))


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

  (define grammar
    '((S (X X))
      (X (a X)
         (b))))

  (define input
    `(a a a b a b))

  (define expected
    `(S (X a (X a (X a (X b)))) (X a (X b))))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Nested grammar.
  ;;
  ;;   Grammar:
  ;;
  ;; Y -> W | c
  ;; W -> S S
  ;; S -> X X
  ;; X -> a X
  ;; X -> b
  ;;

  (define grammar
    '((Y (W) (c))
      (W (S S))
      (S (X X))
      (X (a X)
         (b))))

  (define input
    `(c))

  (define expected
    `(Y c))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Nested grammar.
  ;;
  ;;   Grammar:
  ;;
  ;; Y -> W | c
  ;; W -> S S
  ;; S -> X X
  ;; X -> a X
  ;; X -> b
  ;;

  (define grammar
    '((Y (W) (c))
      (W (S S))
      (S (X X))
      (X (a X)
         (b))))

  (define input
    `(a b a b a b a b))

  (define expected
    `(Y (W (S (X a (X b)) (X a (X b))) (S (X a (X b)) (X a (X b))))))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Nested grammar.
  ;;
  ;;   Grammar:
  ;;
  ;; Y -> W | c
  ;; W -> S S
  ;; S -> X X
  ;; X -> a X
  ;; X -> b
  ;;

  (define grammar
    '((Y (W) (c))
      (W (S S))
      (S (X X))
      (X (a X)
         (b))))

  (define input
    `(a b a a a a b a b a b))

  (define expected
    `(Y (W (S (X a (X b)) (X a (X a (X a (X a (X b)))))) (S (X a (X b)) (X a (X b))))))

  (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Ambiguous arithmetic expression grammar.
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; E -> T
;;   ;; E -> < E >
;;   ;; E -> E + E
;;   ;; E -> E * E
;;   ;; T -> x | y | z
;;   ;;

;;   (define grammar
;;     `((E (T) (< E >) (E + E) (E * E))
;;       (T (x) (y) (z))))

;;   (define input
;;     `(x * y + y))

;;   (define expected
;;     `(E (T x) * (E (T y) + (E (T y)))))

;;   (assert-throw
;;    'parse-conflict
;;    (test-case grammar input expected)))


(let ()
  ;;
  ;; Simple arithmetic expression grammar.
  ;;
  ;;   Grammar:
  ;;
  ;; E -> T
  ;; E -> < E >
  ;; E -> + T E
  ;; E -> * T E
  ;; T -> x | y | z
  ;;

  (define grammar
    `((E (T) (< E >) (+ T E) (* T E))
      (T (x) (y) (z))))

  (define input
    `(+ x y))

  (define expected
    `(E + (T x) (E (T y))))

  (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Simple arithmetic expression grammar.
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; E -> T
;;   ;; E -> < E >
;;   ;; E -> T + E
;;   ;; E -> T * E
;;   ;; T -> x | y | z
;;   ;;

;;   (define grammar
;;     `((E (T) (< E >) (T + E) (T * E))
;;       (T (x) (y) (z))))

;;   (define input
;;     `(x * < y + y >))

;;   (define expected
;;     `(E (T x) * (E < (E (T y) + (E (T y))) >)))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Simple arithmetic expression grammar.
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; E -> T
;;   ;; E -> < E >
;;   ;; E -> T + E
;;   ;; E -> T * E
;;   ;; T -> x | y | z
;;   ;;

;;   (define grammar
;;     `((E (T) (< E >) (T + E) (T * E))
;;       (T (x) (y) (z))))

;;   (define input
;;     `(x * y + y))

;;   (define expected
;;     `(E (T x) * (E (T y) + (E (T y)))))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Simple arithmetic expression grammar.
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; E -> T
;;   ;; E -> < E >
;;   ;; E -> T + E
;;   ;; E -> T * E
;;   ;; T -> x | y | z
;;   ;;

;;   (define grammar
;;     `((E (T) (< E >) (T + E) (T * E))
;;       (T (x) (y) (z))))

;;   (define input
;;     `(x + y + y + z))

;;   (define expected
;;     `(E (T x) + (E (T y) + (E (T y) + (E (T z))))))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Simple arithmetic expression grammar.
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; E -> T
;;   ;; E -> < E >
;;   ;; E -> T + E
;;   ;; E -> T * E
;;   ;; T -> x | y | z
;;   ;;

;;   (define grammar
;;     `((E (T) (< E >) (T + E) (T * E))
;;       (T (x) (y) (z))))

;;   (define input
;;     `(< x + y > + y + z))

;;   (define expected
;;     (parselynn:ll-reject-action:make))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Arithmetic expression grammar.
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; E -> T
;;   ;; E -> T + E
;;   ;; E -> T * E
;;   ;; T -> x | y | z
;;   ;; T -> < E >
;;   ;;

;;   (define grammar
;;     `((E (T) (T + E) (T * E))
;;       (T (x) (y) (z) (< E >))))

;;   (define input
;;     `(< x + y > + y + z))

;;   (define expected
;;     `(E (T < (E (T x) + (E (T y))) >) + (E (T y) + (E (T z)))))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Arithmetic expression grammar.
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; E -> T
;;   ;; E -> T + E
;;   ;; E -> T * E
;;   ;; T -> x | y | z
;;   ;; T -> < E >
;;   ;;

;;   (define grammar
;;     `((E (T) (T + E) (T * E))
;;       (T (x) (y) (z) (< E >))))

;;   (define input
;;     `(< x + y > + y + < z * y + < y + x > >))

;;   (define expected
;;     `(E (T < (E (T x) + (E (T y))) >) + (E (T y) + (E (T < (E (T z) * (E (T y) + (E (T < (E (T y) + (E (T x))) >)))) >)))))

;;   (test-case grammar input expected))


(let ()
  ;;
  ;; Arithmetic expression grammar [2].
  ;;
  ;;   Grammar:
  ;;
  ;; E -> T E^
  ;; E^ -> + E |
  ;; T -> n0 | n1 | n2 | n3 | n4 | n5 | n6 | n7 | n8 | n9
  ;;

  (define grammar
    `((E (T E^))
      (E^ (+ E) ())
      (T (n0) (n1) (n2) (n3) (n4) (n5) (n6) (n7) (n8) (n9))))

  (define input
    `(n0 + n1 + n2 + n3))

  (define expected
    `(E (T n0)
        (E^ + (E (T n1) (E^ + (E (T n2) (E^ + (E (T n3) (E^)))))))))

  (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Arithmetic expression grammar [3].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; E -> T | E + T
;;   ;; T -> n0 | n1 | n2 | n3 | n4 | n5 | n6 | n7 | n8 | n9
;;   ;;

;;   (define grammar
;;     `((E (T) (E + T))
;;       (T (n0) (n1) (n2) (n3) (n4) (n5) (n6) (n7) (n8) (n9))))

;;   (define input
;;     `(n0 + n1 + n2 + n3))

;;   (define expected
;;     `(E (E (E (E (T n0)) + (T n1)) + (T n2)) + (T n3)))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Arithmetic expression grammar [4].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; E -> T | T + E
;;   ;; T -> n0 y0 | n1 y1 | n2 y2 | n3 y3 | n4 y4 | n5 y5 | n6 y6 | n7 y7 | n8 y8 | n9 y9
;;   ;;

;;   (define grammar
;;     `((E (T) (T + E))
;;       (T (n0 y0) (n1 y1) (n2 y2) (n3 y3) (n4 y4) (n5 y5) (n6 y6) (n7 y7) (n8 y8) (n9 y9))))

;;   (define input
;;     `(n0 y0 + n1 y1 + n2 y2 + n3 y3))

;;   (define expected
;;     `(E (T n0 y0) + (E (T n1 y1) + (E (T n2 y2) + (E (T n3 y3))))))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Ambiguous arithmetic expression grammar [2].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; E →    E A T
;;   ;; |      T.
;;   ;; A →    S + S.
;;   ;; T →    S num S.
;;   ;; S →    space S | .
;;   ;;
;;   ;; Note: see conflicts at https://smlweb.cpsc.ucalgary.ca/ll1.php?grammar=E+-%3E+E+A+T+%7C+T.%0AA+-%3E+S+%2B+S.%0AT+-%3E+S+num+S.%0AS+-%3E+space+S+%7C+.&substs=
;;   ;;

;;   (define grammar
;;     `((E (E A T) (T))
;;       (A (S + S))
;;       (T (S num S))
;;       (S (space S) ())))

;;   (define input
;;     `(num space + space num))

;;   (define expected
;;     `(E (E (T (S) num (S))) (A (S) + (S)) (T (S) num (S))))

;;   (assert-throw
;;    'parse-conflict
;;    (test-case grammar input expected)))


;; (let ()
;;   ;;
;;   ;; Ambiguous arithmetic expression grammar [2].
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; E →    E A T
;;   ;; |      T.
;;   ;; A →    S + S.
;;   ;; T →    S num S.
;;   ;; S →    space S | .
;;   ;;
;;   ;; Note: see conflicts at https://smlweb.cpsc.ucalgary.ca/ll1.php?grammar=E+-%3E+E+A+T+%7C+T.%0AA+-%3E+S+%2B+S.%0AT+-%3E+S+num+S.%0AS+-%3E+space+S+%7C+.&substs=
;;   ;;

;;   (define grammar
;;     `((E (E A T) (T))
;;       (A (S + S))
;;       (T (S num S))
;;       (S (space S) ())))

;;   (define input
;;     `(num + num))

;;   (define expected
;;     `(E (E (T (S) num (S))) (A (S) + (S)) (T (S) num (S))))

;;   (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Attributed arithmetic expression grammar.
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; E -> T
;;   ;; E -> T + E
;;   ;; E -> T * E
;;   ;; T -> x | y | z
;;   ;; T -> < E >
;;   ;;

;;   (define grammar
;;     `((E (T) (T + E) (T * E))
;;       (T (x) (y) (z) (< E >))))

;;   (define callback-alist
;;     (list
;;      (cons '(T (x)) '(vector $0 $1))))

;;   (define input
;;     `(< x + y > + y + z))

;;   (define expected
;;     `(E (T < (E #(T x) + (E (T y))) >) + (E (T y) + (E (T z)))))

;;   (parameterize ((callback-alist/p callback-alist))
;;     (test-case grammar input expected)))


(let ()
  ;;
  ;; Attributed arithmetic expression grammar.
  ;;
  ;;   Grammar:
  ;;
  ;; E -> T
  ;; E -> + E E
  ;; E -> * E E
  ;; E -> < E >
  ;; T -> x | y | z
  ;;

  (define grammar
    `((E (T) (+ E E) (* E E) (< E >))
      (T (x) (y) (z))))

  (define callback-alist
    (list
     (cons '(T (x)) '((lambda _ 5)))))

  (define input
    `(+ < + < + x y > y > z))

  (define expected
    `(E + (E < (E + (E < (E + (E 5) (E (T y))) >) (E (T y))) >) (E (T z))))

  (parameterize ((callback-alist/p callback-alist))
    (test-case grammar input expected)))


;; (let ()
;;   ;;
;;   ;; Attributed arithmetic expression grammar.
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; E -> T
;;   ;; E -> T + E
;;   ;; E -> T * E
;;   ;; T -> x | y | z
;;   ;; T -> < E >
;;   ;;

;;   (define grammar
;;     `((E (T) (T + E) (T * E))
;;       (T (x) (y) (z) (< E >))))

;;   (define callback-alist
;;     (list
;;      (cons '(T (x)) '((lambda _ 5)))
;;      (cons '(T (y)) '((lambda _ 7)))
;;      (cons '(T (z)) '((lambda _ 3)))
;;      ))

;;   (define input
;;     `(< x + y > + y + z))

;;   (define expected
;;     `(E (T < (E 5 + (E 7)) >) + (E 7 + (E 3))))

;;   (parameterize ((callback-alist/p callback-alist))
;;     (test-case grammar input expected)))


(let ()
  ;;
  ;; Attributed arithmetic expression grammar.
  ;;
  ;;   Grammar:
  ;;
  ;; E -> T
  ;; E -> + E E
  ;; E -> * E E
  ;; E -> < E >
  ;; T -> x | y | z
  ;;

  (define grammar
    `((E (T) (+ E E) (* E E) (< E >))
      (T (x) (y) (z))))

  (define callback-alist
    (list
     (cons '(T (x)) '((lambda _ 5)))
     (cons '(T (y)) '((lambda _ 7)))
     (cons '(T (z)) '((lambda _ 3)))
     (cons '(E (T)) '((lambda _ $1)))
     (cons '(T (< E >)) '((lambda _ $2)))
     ))

  (define input
    `(+ < + < + x y > y > z))

  (define expected
    `(E + (E < (E + (E < (E + 5 7) >) 7) >) 3))

  (parameterize ((callback-alist/p callback-alist))
    (test-case grammar input expected)))


;; (let ()
;;   ;;
;;   ;; Attributed arithmetic expression grammar.
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; E -> T
;;   ;; E -> T + E
;;   ;; E -> T * E
;;   ;; T -> x | y | z
;;   ;; T -> < E >
;;   ;;

;;   (define grammar
;;     `((E (T) (T + E) (T * E))
;;       (T (x) (y) (z) (< E >))))

;;   (define callback-alist
;;     (list
;;      (cons '(T (x)) '5)
;;      (cons '(T (y)) '7)
;;      (cons '(T (z)) '3)
;;      (cons '(E (T)) '$1)
;;      (cons '(T (< E >)) '$2)
;;      ))

;;   (define input
;;     `(< x + y > + y + z))

;;   (define expected
;;     `(E (E 5 + 7) + (E 7 + 3)))

;;   (parameterize ((callback-alist/p callback-alist))
;;     (test-case grammar input expected)))


(let ()
  ;;
  ;; Attributed arithmetic expression grammar.
  ;;
  ;;   Grammar:
  ;;
  ;; E -> T
  ;; E -> + E E
  ;; E -> * E E
  ;; E -> < E >
  ;; T -> x | y | z
  ;;

  (define grammar
    `((E (T) (+ E E) (* E E) (< E >))
      (T (x) (y) (z))))

  (define callback-alist
    (list
     (cons '(T (x)) '5)
     (cons '(T (y)) '7)
     (cons '(T (z)) '3)
     (cons '(E (T)) '$1)
     (cons '(E (< E >)) '$2)
     (cons '(E (+ E E)) '(+ $2 $3))
     (cons '(E (* E E)) '(* $2 $3))
     ))

  (define input
    `(+ < + < + x y > y > z))

  (define expected
    22)

  (parameterize ((callback-alist/p callback-alist))
    (test-case grammar input expected)))


(let ()
  ;;
  ;; Attributed arithmetic expression grammar.
  ;;
  ;;   Grammar:
  ;;
  ;; E -> T
  ;; E -> + E E
  ;; E -> * E E
  ;; E -> < E >
  ;; T -> x | y | z
  ;;

  (define grammar
    `((E (T) (+ E E) (* E E) (< E >))
      (T (x) (y) (z))))

  (define callback-alist
    (list
     (cons '(T (x)) '5)
     (cons '(T (y)) '7)
     (cons '(T (z)) '3)
     (cons '(E (T)) '$1)
     (cons '(E (< E >)) '$2)
     (cons '(E (+ E E)) '(list '+ $2 $3))
     (cons '(E (* E E)) '(list '* $2 $3))
     ))

  (define input
    `(+ < + < + x y > y > z))

  (define expected
    `(+ (+ (+ 5 7) 7) 3))

  (parameterize ((callback-alist/p callback-alist))
    (test-case grammar input expected)))
