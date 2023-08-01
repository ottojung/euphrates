
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates list-split-on) list-split-on))
   (import
     (only (scheme base)
           begin
           cond-expand
           even?
           let
           list
           quote))))


;; list-split-on

(let ()
  (assert= '((1) (3) (5) (7))
           (list-split-on even? (list 1 2 3 4 5 6 7)))
  (assert= '((1 3 5 7) (9))
           (list-split-on even? (list 1 3 5 7 2 9)))
  (assert= '((1 3 5 7))
           (list-split-on even? (list 1 3 5 7)))
  (assert= '((1 3) (5 7))
           (list-split-on even? (list 1 3 2 5 7)))
  (assert= '((1 3) () (5 7))
           (list-split-on even? (list 1 3 2 2 5 7)))
  (assert= '((1) (3) (5) ())
           (list-split-on even? (list 1 2 3 4 5 6)))
  (assert= '(())
           (list-split-on even? (list)))
  (assert= '(() () () ())
           (list-split-on even? (list 2 4 6)))
  )
