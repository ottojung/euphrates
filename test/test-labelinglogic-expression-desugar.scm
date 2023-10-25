
(let ()
  (assert=
   '(or a (or b (or c d)))
   (labelinglogic:expression:desugar
    '(or a b c d))))

(let ()
  (assert=
   '(or a (or b (or z (or c d))))
   (labelinglogic:expression:desugar
    '(or a (or b z) c d))))

(let ()
  (assert=
   '(or a)
   (labelinglogic:expression:desugar
    '(or a))))

(let ()
  (assert=
   '(or)
   (labelinglogic:expression:desugar
    '(or))))

(let ()
  (assert=
   '(or a (or b (or z c)))
   (labelinglogic:expression:desugar
    '(or a (or b z) c))))

(let ()
  (assert=
   '(or a (or b (or z c)))
   (labelinglogic:expression:desugar
    '(or a (or b z) (or c)))))

(let ()
  (assert=
   '(or a (or b (or z c)))
   (labelinglogic:expression:desugar
    '(or a (or b z) (or c (or))))))

(let ()
  (assert=
   '(or a (or b (or z c)))
   (labelinglogic:expression:desugar
    '(or a (or b z) (or (or) c (or))))))

(let ()
  (assert=
   '(or a (or b z))
   (labelinglogic:expression:desugar
    '(or a (or b z) (or (or) (or) (or))))))

;; Test with nested operations of different types
(let ()
  (assert=
   '(seq a (seq b (seq (and c d) (seq (or f g) (seq h i)))))
   (labelinglogic:expression:desugar
    '(seq a b (and c d) (or f g) h i))))

(let ()
  (assert=
   '(seq a (seq b (seq (and c (and d e)) (seq (or f g) (seq h i)))))
   (labelinglogic:expression:desugar
    '(seq a b (and c d e) (or f g) h i))))

(let ()
  (assert=
   `(and a (and b (and (seq c (seq d e)) (and (or f g) (and h i)))))
   (labelinglogic:expression:desugar
    '(and a b (seq c d e) (or f g) h i))))
