


(assert= '((0 . 2) (2 . 3) (4 . 4))
         (map (fn-pair (a b) (cons (* a 2) (+ b 2)))
              (list-zip-with cons (range 3) (range 3))))
