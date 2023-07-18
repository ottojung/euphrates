
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates list-zip-with) list-zip-with))
   (import
     (only (scheme base)
           begin
           cond-expand
           let
           list
           quote))))



(let () ;; list-zip-with
  (assert= '((1 a) (2 b) (3 c))
           (list-zip-with list '(1 2 3) '(a b c)))
  (assert= '((1 a) (2 b))
           (list-zip-with list '(1 2 3) '(a b)))
  (assert= '((1 a) (2 b))
           (list-zip-with list '(1 2) '(a b)))
  (assert= '((1 a) (2 b))
           (list-zip-with list '(1 2) '(a b c)))
  (assert= '()
           (list-zip-with list '() '(a b c)))
  )
