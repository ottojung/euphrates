

;; cartesian-product

(let ()
  (assert=HS '((1 . a) (1 . b) (1 . c) (2 . a) (2 . b) (2 . c) (3 . a) (3 . b) (3 . c))
             (cartesian-product '(1 2 3) '(a b c))))
