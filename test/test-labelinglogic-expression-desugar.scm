
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
   '(list a)
   (labelinglogic:expression:desugar
    '(list a))))

(let ()
  (assert=
   '(list a)
   (labelinglogic:expression:desugar
    '(or (list a)))))

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
   '(or a (or (list b) (or z c)))
   (labelinglogic:expression:desugar
    '(or a (or (list b) z) c))))

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
   '(list a (list b (list (and c d) (list (or f g) (list h i)))))
   (labelinglogic:expression:desugar
    '(list a (list b (list (and c d) (list (or f g) (list h i))))))))

(let ()
  (assert=
   '(list a (list b (list (and c (and d e)) (list (or f g) (list h i)))))
   (labelinglogic:expression:desugar
    '(list a (list b (list (and c d e) (list (or f g) (list h i))))))))

(let ()
  (assert=
   `(and a (and b (and (list c (list d e)) (and (or f g) (and h i)))))
   (labelinglogic:expression:desugar
    '(and a b (list c (list d e)) (or f g) h i))))

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
   '(list a)
   (labelinglogic:expression:desugar
    '(list a))))

(let ()
  (assert=
   '(list a)
   (labelinglogic:expression:desugar
    '(and (list a)))))

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
   '(and a (and (list b) (and z c)))
   (labelinglogic:expression:desugar
    '(and a (and (list b) z) c))))

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
   '(list a (list b (list (or c d) (list (and f g) (list h i)))))
   (labelinglogic:expression:desugar
    '(list a (list b (list (or c d) (list (and f g) (list h i))))))))

(let ()
  (assert=
   '(list a (list b (list (or c (or d e)) (list (and f g) (list h i)))))
   (labelinglogic:expression:desugar
    '(list a (list b (list (or c d e) (list (and f g) (list h i))))))))

(let ()
  (assert=
   `(or a (or b (or (list c (list d e)) (or (and f g) (or h i)))))
   (labelinglogic:expression:desugar
    '(or a b (list c (list d e)) (and f g) h i))))

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
