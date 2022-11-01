
%run guile

;; list-deduplicate
%use (assert=HS) "./src/assert-equal-hs.scm"
%use (list-deduplicate) "./src/list-deduplicate.scm"

(let ()
  (assert=HS '(a b c d)
             (list-deduplicate '(a b c d)))
  (assert=HS '(a b c d)
             (list-deduplicate '(a b c d c)))
  (assert=HS '(a b c d)
             (list-deduplicate '(a b c a a a d a)))
  (assert=HS '()
             (list-deduplicate '())))
