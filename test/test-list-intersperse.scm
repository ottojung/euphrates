

;; list-intersperse

(let ()
  (assert= (list 0 'x 1 'x 2)
           (list-intersperse 'x (list 0 1 2)))
  (assert= (list 0)
           (list-intersperse 'x (list 0)))
  (assert= (list)
           (list-intersperse 'x (list)))
  (assert= 199
           (length (list-intersperse 'x (range 100)))))
