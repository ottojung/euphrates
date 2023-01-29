
(cond-expand
 (guile
  (define-module (test-list-deduplicate)
    :use-module ((euphrates assert-equal-hs) :select (assert=HS))
    :use-module ((euphrates list-deduplicate) :select (list-deduplicate)))))

;; list-deduplicate

(let ()
  (assert=HS '(a b c d)
             (list-deduplicate '(a b c d)))
  (assert=HS '(a b c d)
             (list-deduplicate '(a b c d c)))
  (assert=HS '(a b c d)
             (list-deduplicate '(a b c a a a d a)))
  (assert=HS '()
             (list-deduplicate '())))
