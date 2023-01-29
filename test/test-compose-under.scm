
(cond-expand
 (guile
  (define-module (test-compose-under)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates compose-under) :select (compose-under))
    :use-module ((euphrates range) :select (range)))))


(let () ;; compose-under
  (assert= (list 10 25 0)
           ((compose-under list + * -) 5 5))
  (assert= (list 0 1 3 5 7 9)
           (filter (compose-under or zero? odd?) (range 10))))
