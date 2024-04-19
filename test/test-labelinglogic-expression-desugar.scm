
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
   '(tuple a)
   (labelinglogic:expression:desugar
    '(tuple a))))

(let ()
  (assert=
   '(tuple a)
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
   '(or a (or (tuple b) (or z c)))
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

(let ()
  (assert=
   '(or a (or (not b) (or c d)))
   (labelinglogic:expression:desugar
    '(or a (not b) c d))))

(let ()
  (assert=
   '(or a (or (not (or b (or c d))) e))
   (labelinglogic:expression:desugar
    '(or a (not (or b c d)) e))))

(let ()
  (assert=
   '(and a (and b (and c d)))
   (labelinglogic:expression:desugar
    '(and a b c d))))

(let ()
  (assert=
   '(and a (and b (and z (and c d))))
   (labelinglogic:expression:desugar
    '(and a (and b z) c d))))

(let ()
  (assert=
   'a
   (labelinglogic:expression:desugar
    '(and a))))

(let ()
  (assert=
   '(tuple a)
   (labelinglogic:expression:desugar
    '(tuple a))))

(let ()
  (assert=
   '(tuple a)
   (labelinglogic:expression:desugar
    '(and (tuple a)))))

(let ()
  (assert=
   '(and)
   (labelinglogic:expression:desugar
    '(and))))

(let ()
  (assert=
   '(and a (and b (and z c)))
   (labelinglogic:expression:desugar
    '(and a (and b z) c))))

(let ()
  (assert=
   '(and a (and (tuple b) (and z c)))
   (labelinglogic:expression:desugar
    '(and a (and (tuple b) z) c))))

(let ()
  (assert=
   '(and a (and b (and z c)))
   (labelinglogic:expression:desugar
    '(and a (and b z) (and c)))))

(let ()
  (assert=
   '(and a (and b (and z c)))
   (labelinglogic:expression:desugar
    '(and a (and b z) (and c (and))))))

(let ()
  (assert=
   '(and a (and b (and z c)))
   (labelinglogic:expression:desugar
    '(and a (and b z) (and (and) c (and))))))

(let ()
  (assert=
   '(and a (and b z))
   (labelinglogic:expression:desugar
    '(and a (and b z) (and (and) (and) (and))))))

;; Test with nested operations of different types
(let ()
  (assert=
   '(tuple a (tuple b (tuple (or c d) (tuple (and f g) (tuple h i)))))
   (labelinglogic:expression:desugar
    '(tuple a (tuple b (tuple (or c d) (tuple (and f g) (tuple h i))))))))

(let ()
  (assert=
   '(tuple a (tuple b (tuple (or c (or d e)) (tuple (and f g) (tuple h i)))))
   (labelinglogic:expression:desugar
    '(tuple a (tuple b (tuple (or c d e) (tuple (and f g) (tuple h i))))))))

(let ()
  (assert=
   `(or a (or b (or (tuple c (tuple d e)) (or (and f g) (or h i)))))
   (labelinglogic:expression:desugar
    '(or a b (tuple c (tuple d e)) (and f g) h i))))

(let ()
  (assert=
   '(and a (and (not b) (and c d)))
   (labelinglogic:expression:desugar
    '(and a (not b) c d))))

(let ()
  (assert=
   '(and a (and (not (and b (and c d))) e))
   (labelinglogic:expression:desugar
    '(and a (not (and b c d)) e))))
