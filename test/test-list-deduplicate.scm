
(cond-expand
  (guile)
  ((not guile)
   (import
     (only (euphrates assert-equal-hs) assert=HS))
   (import
     (only (euphrates list-deduplicate)
           list-deduplicate))
   (import
     (only (scheme base) begin cond-expand let quote))))


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
