
%run guile

;; appcomp
%use (assert=) "./src/assert-equal.scm"
%use (appcomp comp) "./src/comp.scm"

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
