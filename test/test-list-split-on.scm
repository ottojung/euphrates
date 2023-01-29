
%run guile

;; list-split-on
%use (assert=) "./euphrates/assert-equal.scm"
%use (list-split-on) "./euphrates/list-split-on.scm"

(let ()
  (assert= '((1) (3) (5) (7))
           (list-split-on even? (list 1 2 3 4 5 6 7)))
  (assert= '((1 3 5 7) (9))
           (list-split-on even? (list 1 3 5 7 2 9)))
  (assert= '((1 3 5 7))
           (list-split-on even? (list 1 3 5 7)))
  (assert= '((1 3) (5 7))
           (list-split-on even? (list 1 3 2 2 5 7)))
  (assert= '()
           (list-split-on even? (list 2 4 6)))
  )
