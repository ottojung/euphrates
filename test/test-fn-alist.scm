
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates fn-alist) fn-alist))
   (import
     (only (scheme base)
           +
           begin
           cond-expand
           define
           quasiquote))))



(define mult
  (fn-alist (X Y) (+ X Y)))

(assert= 6 (mult `((X . 2) (Y . 4))))
(assert= 7 (mult `((Z . 5) (X . 3) (Y . 4))))
(assert= 8 (mult `((Z . 5) (X . 3) (Y . 5) (M . 9))))
(assert= 9 (mult `((Z . 5) (X . 5) (X . 3) (Y . 4))))
