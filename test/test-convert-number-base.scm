
(cond-expand
 (guile
  (define-module (test-convert-number-base)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates convert-number-base) :select (convert-number-base)))))

;; convert-number-base

(let ()
  (for-each
   (lambda (p)
     (assert= (car p) (convert-number-base 2 10 (cdr p)))
     (assert= (cdr p) (convert-number-base 10 2 (car p))))
   (list
    (cons (list #\9) (list #\1 #\0 #\0 #\1))
    (cons "9" "1001")
    (cons "8" "1000")
    (cons "0.375" "0.011")
    (cons "9.375" "1001.011")
    (cons "8.375" "1000.011")))

  (assert= "f" (convert-number-base 2 16 "1111"))
  (assert= "1111" (convert-number-base 16 2 "f")))
