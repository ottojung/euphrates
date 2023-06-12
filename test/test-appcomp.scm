

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
