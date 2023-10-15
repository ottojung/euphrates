
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
