
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates list-zip) list-zip))
   (import
     (only (scheme base) begin cond-expand let quote))))



(let () ;; list-zip
  (assert= '((1 . a) (2 . b) (3 . c))
           (list-zip '(1 2 3) '(a b c)))
  (assert= '((1 . a) (2 . b))
           (list-zip '(1 2 3) '(a b)))
  (assert= '((1 . a) (2 . b))
           (list-zip '(1 2) '(a b)))
  (assert= '((1 . a) (2 . b))
           (list-zip '(1 2) '(a b c)))
  (assert= '()
           (list-zip '() '(a b c)))
  )
