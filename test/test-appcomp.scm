
(cond-expand
 (guile
  (define-module (test-appcomp)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates comp) :select (appcomp comp)))))

;; appcomp

(let ()
  (define f
    (comp (+ 2)
          ((lambda (x) (expt x 2)))
          (* 2)))

  (assert= 32 (f 2))

  (assert= 32
           (appcomp 2
                    (+ 2)
                    ((lambda (x) (expt x 2)))
                    (* 2))))
