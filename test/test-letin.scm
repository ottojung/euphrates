
(cond-expand
 (guile
  (define-module (test-letin)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates letin) :select (letin)))))

;; letin

(let ()
  (letin
   [k (letin
       [i 2]
       [c 3]
       [r (+ i c)])]
   (do (assert= k 5))
   [[c k] (letin
           [i 2]
           [(c k) (values 3 4)]
           [[r m] (values (+ i c k) 0)])]
   (do (assert= c 9))
   (do (assert= k 0))))
