
(let ()
  (assert=
   '(or a (or b (or c d)))
   (labelinglogic::expression:desugar
    '(or a b c d))))

(let ()
  (assert=
   '(or a (or b (or z (or c d))))
   (labelinglogic::expression:desugar
    '(or a (or b z) c d))))
