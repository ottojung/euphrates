
%run guile

;; assert=HS
%use (assert=HS) "./src/assert-equal-hs.scm"

(let ()
  (assert=HS '(a b c d) '(a b c d))
  (assert=HS '(a b c d) '(b d c a)))
