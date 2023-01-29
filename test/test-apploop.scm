
(cond-expand
 (guile
  (define-module (test-apploop)
    :use-module ((euphrates apploop) :select (apploop))
    :use-module ((euphrates assert-equal) :select (assert=)))))

;; apploop

(let ()
  (assert=
   120
   (apploop [x] [5] (if (= 0 x) 1 (* x (loop (- x 1)))))))
