
(let ()
  (assert=
   '(or a b c d)
   (labelinglogic:expression:sugarify
    '(or a (or b (or c d))))))

(let ()
  (assert=
   '(or a b c d)
   (labelinglogic:expression:sugarify
    '(or a (or b c) d))))

(let ()
  (assert=
   '(or a (and b c d) e f)
   (labelinglogic:expression:sugarify
    '(or a (or (and b c d) (or e f))))))

;; Test nested expressions that needs to be flattened
(let ()
  (assert=
   '(tuple a (tuple b (tuple c (tuple d e))))
   (labelinglogic:expression:sugarify
    '(tuple a (tuple b (tuple c (tuple d e)))))))

(let ()
  (assert=
   '(tuple a (tuple b (or c d) (tuple e f)))
   (labelinglogic:expression:sugarify
    '(tuple a (tuple b (or c d) (tuple e f))))))

;; Test expressions that does not need to be flattened
(let ()
  (assert=
   '(or a b)
   (labelinglogic:expression:sugarify
    '(or a b))))

(let ()
  (assert=
   '(tuple a (and b c))
   (labelinglogic:expression:sugarify
    '(tuple a (and b c)))))

;; Test with nested operations of different types
(let ()
  (assert=
   '(and a b (tuple c (tuple d e)) f g)
   (labelinglogic:expression:sugarify
    '(and a (and b (tuple c (tuple d e)) (and f g))))))

(let ()
  (assert=
   '(or a (and b c d) (tuple e f) g h)
   (labelinglogic:expression:sugarify
    '(or a (or (and b c d) (tuple e f) (or g h))))))

;; Test with nested operations of the same type
(let ()
  (assert=
   '(or a b c d e f g)
   (labelinglogic:expression:sugarify
    '(or a (or b (or c (or d e)) (or f g))))))

(let ()
  (assert=
   '(and a b c d e f g h)
   (labelinglogic:expression:sugarify
    '(and a (and (and b c d) (and e f)) (and g h)))))

;; Test nested tupleuences that do not need to be flattened
(let ()
  (assert=
    '(tuple a (tuple b (tuple c (tuple d e))))
   (labelinglogic:expression:sugarify
    '(tuple a (tuple b (tuple c (tuple d e)))))))

(let ()
  (assert=
   '(tuple a (tuple b (or c d) (tuple e f)))
   (labelinglogic:expression:sugarify
    '(tuple a (tuple b (or c d) (tuple e f))))))

;; Test with nested operations of different types
(let ()
  (assert=
   '(tuple a (tuple b (and c d e) (or f g)) (tuple h i))
   (labelinglogic:expression:sugarify
    '(tuple a (tuple b (and c (and d e)) (or f g)) (tuple h i)))))

(let ()
  (assert=
   '(and a b (tuple c (tuple d e)) (or f g) h i)
   (labelinglogic:expression:sugarify
    '(and a (and b (tuple c (tuple d e)) (or f g)) (and h i)))))

(let ()
  (assert-throw
   'unknown-expr-type
   (labelinglogic:expression:sugarify '(a b c))))
