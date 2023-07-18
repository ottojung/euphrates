
(cond-expand
  (guile)
  ((not guile)
   (import
     (only (euphrates assert-equal-hs) assert=HS))
   (import
     (only (scheme base) begin cond-expand let quote))))


;; assert=HS

(let ()
  (assert=HS '(a b c d) '(a b c d))
  (assert=HS '(a b c d) '(b d c a)))
