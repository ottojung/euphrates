
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates comp) appcomp comp))
   (import
     (only (scheme base)
           *
           +
           begin
           cond-expand
           define
           expt
           lambda
           let))))


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
