
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates list-take-while)
           list-take-while))
   (import
     (only (scheme base)
           begin
           cond-expand
           even?
           let
           quote))))


;; list-take-while

(let ()
  (assert= '(2 4 6 8) (list-take-while even? '(2 4 6 8 9 3 1)))
  (assert= '() (list-take-while even? '(1 2 4 6 8 9 3 1)))
  (assert= '() (list-take-while even? '()))
  (assert= '(2 4 6 8) (list-take-while even? '(2 4 6 8)))
  )
