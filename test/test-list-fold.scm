
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates list-fold) list-fold))
   (import
     (only (scheme base)
           *
           +
           _
           begin
           call-with-values
           cond-expand
           lambda
           let
           quote
           values))))


;; list-fold

(let ()
  (assert=
   10
   (list-fold
    (acc 0)
    (cur '(1 2 3 4))
    (+ acc cur)))

  (assert=
   '(10 48)
   (call-with-values
       (lambda _
         (list-fold
          ((acc1 acc2) (values 0 2))
          (cur '(1 2 3 4))
          (values (+ acc1 cur) (* acc2 cur))))
     (lambda x x)))

  )
