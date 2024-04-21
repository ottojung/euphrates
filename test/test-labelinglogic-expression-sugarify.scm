
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
   '(list a (list b (list c (list d e))))
   (labelinglogic:expression:sugarify
    '(list a (list b (list c (list d e)))))))

(let ()
  (assert=
   '(list a (list b (or c d) (list e f)))
   (labelinglogic:expression:sugarify
    '(list a (list b (or c d) (list e f))))))

;; Test expressions that does not need to be flattened
(let ()
  (assert=
   '(or a b)
   (labelinglogic:expression:sugarify
    '(or a b))))

(let ()
  (assert=
   '(list a (and b c))
   (labelinglogic:expression:sugarify
    '(list a (and b c)))))

;; Test with nested operations of different types
(let ()
  (assert=
   '(and a b (list c (list d e)) f g)
   (labelinglogic:expression:sugarify
    '(and a (and b (list c (list d e)) (and f g))))))

(let ()
  (assert=
   '(or a (and b c d) (list e f) g h)
   (labelinglogic:expression:sugarify
    '(or a (or (and b c d) (list e f) (or g h))))))

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

;; Test nested listuences that do not need to be flattened
(let ()
  (assert=
    '(list a (list b (list c (list d e))))
   (labelinglogic:expression:sugarify
    '(list a (list b (list c (list d e)))))))

(let ()
  (assert=
   '(list a (list b (or c d) (list e f)))
   (labelinglogic:expression:sugarify
    '(list a (list b (or c d) (list e f))))))

;; Test with nested operations of different types
(let ()
  (assert=
   '(list a (list b (and c d e) (or f g)) (list h i))
   (labelinglogic:expression:sugarify
    '(list a (list b (and c (and d e)) (or f g)) (list h i)))))

(let ()
  (assert=
   '(and a b (list c (list d e)) (or f g) h i)
   (labelinglogic:expression:sugarify
    '(and a (and b (list c (list d e)) (or f g)) (and h i)))))

(let ()
  (assert-throw
   'unknown-expr-type
   (labelinglogic:expression:sugarify '(a b c))))
