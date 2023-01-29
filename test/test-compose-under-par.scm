
(cond-expand
 (guile
  (define-module (test-compose-under-par)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates compose-under-par) :select (compose-under-par))
    :use-module ((euphrates range) :select (range)))))


(let () ;; compose-under-par
  (assert= (list 5 5 -5)
           ((compose-under-par list + * -) 5 5 5))
  (assert= '((2 0) (3 2) (4 4))
           (map (compose-under-par
                 list (lambda (x) (+ 2 x)) (lambda (x) (* 2 x)))
                (range 3) (range 3))))
