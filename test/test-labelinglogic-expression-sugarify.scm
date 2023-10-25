
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
   '(seq a b c d e)
   (labelinglogic:expression:sugarify
    '(seq a (seq b (seq c (seq d e)))))))

(let ()
  (assert=
   '(seq a b (or c d) e f)
   (labelinglogic:expression:sugarify
    '(seq a (seq b (or c d) (seq e f))))))

;; Test expressions that does not need to be flattened
(let ()
  (assert=
   '(or a b)
   (labelinglogic:expression:sugarify
    '(or a b))))

(let ()
  (assert=
   '(seq a (and b c))
   (labelinglogic:expression:sugarify
    '(seq a (and b c)))))

;; Test with nested operations of different types
(let ()
  (assert=
   '(and a b (seq c d e) f g)
   (labelinglogic:expression:sugarify
    '(and a (and b (seq c (seq d e)) (and f g))))))

(let ()
  (assert=
   '(or a (and b c d) (seq e f) g h)
   (labelinglogic:expression:sugarify
    '(or a (or (and b c d) (seq e f) (or g h))))))

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

;; Test nested sequences that needs to be flattened
(let ()
  (assert=
   '(seq a b c d e)
   (labelinglogic:expression:sugarify
    '(seq a (seq b (seq c (seq d e)))))))

(let ()
  (assert=
   '(seq a b (or c d) e f)
   (labelinglogic:expression:sugarify
    '(seq a (seq b (or c d) (seq e f))))))

;; Test with nested operations of different types
(let ()
  (assert=
   '(seq a b (and c d e) (or f g) h i)
   (labelinglogic:expression:sugarify
    '(seq a (seq b (and c (and d e)) (or f g)) (seq h i)))))

(let ()
  (assert=
   '(and a b (seq c d e) (or f g) h i)
   (labelinglogic:expression:sugarify
    '(and a (and b (seq c (seq d e)) (or f g)) (and h i)))))

(let ()
  (assert-throw
   'unknown-expr-type
   (labelinglogic:expression:sugarify '(a b c))))
