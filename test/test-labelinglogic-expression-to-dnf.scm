
(define-syntax test
  (syntax-rules ()
    ((_ expected input)
     (assert=
      expected
      (labelinglogic:expression:to-dnf
       input)))))


;; Test for a simple OR expression
(test
 '(or x y)
 '(or x y))

;; Test for a simple AND expression
(test
 '(and x y)
 '(and x y))

;; Simple or + and.
(test
 '(or (and x y) (and x z))
 '(and x (or y z)))

;; Simple or + and.
(test
 '(or (and y x) (and z x))
 '(and (or y z) x))

;; Test for De Morgan's laws [1]
(test
 '(or (not x) (not y))
 '(not (and x y)))

;; Test for De Morgan's laws [2]
(test
 '(or (not x) (not y) (not z))
 '(not (and x y z)))

;; Test for double negation
(test
 'x
 '(not (not x)))

;; Test for distributive law conversion to DNF
(test
 '(or a (and b c))
 '(or a (and b c)))

;; Test for distributive law with multiple ANDs
(test
 '(or a (and b c) (and d e))
 '(or a (and b c) (and d e)))

;; Test for distributive law with nested ORs inside ANDs
(test
 '(or (or (and a c) (and b c))
      (or (and a d) (and b d)))
 '(and (or a b) (or c d)))

;; Test for distributive law with nested ANDs inside ORs
(test
 '(or (and a b) (and c d))
 '(or (and a b) (and c d)))

;; Test with nested NOT expressions
(test
 '(and x (not y))
 '(not (or (not x) y)))

;; Test with nested ANDs and ORs
(test
 '(or (or (and a c) (and (not b) c))
      (or (and a d) (and (not b) d)))
 '(and (or a (not b)) (or c d)))

;; Test non-binary [1]
(test
 '(or (and x (and y z))
      (and x (and y w)))
 '(and x y (or z w)))

;; Test non-binary [2]
(test
 '(or (and (and z x) y)
      (and (and w x) y))
 '(and (or z w) x y))

;; Test non-binary [3]
(test
 '(or (and z y)
      (and w y)
      (and x y))
 '(and (or z w x) y))

;; Test non-binary [4]
(test
 '(or (or (and (and (and z y) k) m)
          (and (and (and w y) k) m))
      (or (and (and (and z y) u) m)
          (and (and (and w y) u) m)))
 '(and (or z w) y (or k u) m))

;; Test that involves all operators in a more complex expression
(test
 '(or (or (and (and a (not a)) (not b))
          (and (and a b) (not b)))
      (or (and (and a (not a)) b)
          (and (and a b) b)))
 '(and a (or (not a) b) (or (not b) b)))

(test
 '(and (constant 0) (constant 0) (constant 0) (constant 0) (constant 0))
 '(and (constant 0) (constant 0) (constant 0) (constant 0) (constant 0)))

(test
 '(or (and (constant 0) (constant 0) (constant 0) (constant 0) (constant 0)))
 '(or (and (constant 0) (constant 0) (constant 0) (constant 0) (constant 0))))

;; Test variable.
(test 'x 'x)

;; Test negation.
(test '(not x) '(not x))

;; Test negations 1.
(test 'x '(not (not x)))

;; Test negations 2.
(test '(not x) '(not (not (not x))))

;; Tuples + negation
(test
 '(and (list (constant 1)) (list (not (constant 1))))
 '(and (list (constant 1)) (not (list (constant 1)))))

;; Singleton and.
(test
 '(or (constant 5) (constant 7) (constant 8))
 '(and (or (constant 5) (constant 7) (constant 8))))

;; Complex lists [1]
(test
 '(or (and (list (constant 1)) (list (not (constant 1))))
      (and (list (constant 2)) (list (not (constant 1)))))
 '(and (list (or (constant 1) (constant 2))) (not (list (constant 1)))))

;; Complex lists [2].
(test
 '(or (list (and x y))
      (list (and x z)))
 '(list (and x (or y z))))

;; Complex lists [3].
(test
 '(or (list x m w) (list y m w)
      (list x m z) (list y m z))
 '(list (or x y) m (or w z)))

;; Complex lists [4].
(test
 '(or (list w m (and x y))
      (list w m (and x z)))
 '(list w m (and x (or y z))))

;; Complex lists [5]
(test
 '(or (and (list (and (constant 4) (constant 1)))
           (list (not (constant 1))))
      (and (list (and (constant 4) (constant 2)))
           (list (not (constant 1)))))
 '(and (list (and (constant 4) (or (constant 1) (constant 2))))
       (not (list (constant 1)))))

;; Complex lists [6].
(test
 '(or (and (and (and (list w m x) m) k) u)
      (and (and (and (list w m y) m) k) u))
 '(and (list w m (or x y))
       m k u))

;; Complex expression.
(test

 '(or (or (and (and (r7rs char-numeric?)
                    (not (constant 7))
                    (not (constant 5)))
               (not (r7rs char-numeric?)))
          (and (and (r7rs char-numeric?)
                    (not (constant 7))
                    (not (constant 5)))
               (constant 5))
          (and (and (r7rs char-numeric?)
                    (not (constant 7))
                    (not (constant 5)))
               (constant 7))
          (and (and (r7rs char-numeric?)
                    (not (constant 7))
                    (not (constant 5)))
               (constant 8)))
      (and (r7rs char-numeric?)
           (not (constant 5))
           (not (constant 7))
           (not (constant 8))))

 '(or (and (and (r7rs char-numeric?)
                (not (constant 7))
                (not (constant 5)))
           (not (or (and (r7rs char-numeric?)
                         (not (constant 5))
                         (not (constant 7))
                         (not (constant 8))))))
      (and (r7rs char-numeric?)
           (not (constant 5))
           (not (constant 7))
           (not (constant 8)))))
