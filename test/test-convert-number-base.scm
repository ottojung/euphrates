
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates convert-number-base)
           convert-number-base))
   (import
     (only (scheme base)
           begin
           car
           cdr
           cond-expand
           cons
           for-each
           lambda
           let
           list))))


;; convert-number-base

(let ()
  (for-each
   (lambda (p)
     (assert= (car p) (convert-number-base 2 10 (cdr p)))
     (assert= (cdr p) (convert-number-base 10 2 (car p))))
   (list
    (cons "9" "1001")
    (cons "8" "1000")
    (cons "0.375" "0.011")
    (cons "9.375" "1001.011")
    (cons "8.375" "1000.011")))

  (assert= "f" (convert-number-base 2 16 "1111"))
  (assert= "1111" (convert-number-base 16 2 "f")))
