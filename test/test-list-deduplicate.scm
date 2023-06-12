

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
