
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
   'a
   (labelinglogic:expression:desugar
    '(or a))))

(let ()
  (assert=
   'a
   (labelinglogic:expression:desugar
    '(tuple a))))

(let ()
  (assert=
   'a
   (labelinglogic:expression:desugar
    '(or (tuple a)))))

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
    '(or a (or (tuple b) z) c))))

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
   '(tuple a (tuple b (tuple (and c d) (tuple (or f g) (tuple h i)))))
   (labelinglogic:expression:desugar
    '(tuple a (tuple b (tuple (and c d) (tuple (or f g) (tuple h i))))))))

(let ()
  (assert=
   '(tuple a (tuple b (tuple (and c (and d e)) (tuple (or f g) (tuple h i)))))
   (labelinglogic:expression:desugar
    '(tuple a (tuple b (tuple (and c d e) (tuple (or f g) (tuple h i))))))))

(let ()
  (assert=
   `(and a (and b (and (tuple c (tuple d e)) (and (or f g) (and h i)))))
   (labelinglogic:expression:desugar
    '(and a b (tuple c (tuple d e)) (or f g) h i))))
