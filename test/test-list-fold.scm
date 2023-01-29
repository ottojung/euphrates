
(cond-expand
 (guile
  (define-module (test-list-fold)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates list-fold) :select (list-fold)))))

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
