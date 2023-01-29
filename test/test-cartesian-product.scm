
(cond-expand
 (guile
  (define-module (test-cartesian-product)
    :use-module ((euphrates assert-equal-hs) :select (assert=HS))
    :use-module ((euphrates cartesian-product) :select (cartesian-product)))))

;; cartesian-product

(let ()
  (assert=HS '((1 . a) (1 . b) (1 . c) (2 . a) (2 . b) (2 . c) (3 . a) (3 . b) (3 . c))
             (cartesian-product '(1 2 3) '(a b c))))
