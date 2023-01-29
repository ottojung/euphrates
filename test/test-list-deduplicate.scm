
%run guile

;; list-deduplicate
%use (assert=HS) "./euphrates/assert-equal-hs.scm"
%use (list-deduplicate) "./euphrates/list-deduplicate.scm"

(let ()
  (assert=HS '(a b c d)
             (list-deduplicate '(a b c d)))
  (assert=HS '(a b c d)
             (list-deduplicate '(a b c d c)))
  (assert=HS '(a b c d)
             (list-deduplicate '(a b c a a a d a)))
  (assert=HS '()
             (list-deduplicate '())))
