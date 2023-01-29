
(cond-expand
 (guile
  (define-module (test-assert=HS)
    :use-module ((euphrates assert-equal-hs) :select (assert=HS)))))

;; assert=HS

(let ()
  (assert=HS '(a b c d) '(a b c d))
  (assert=HS '(a b c d) '(b d c a)))
