


(let () ;; compose-under
  (assert= (list 10 25 0)
           ((compose-under list + * -) 5 5))
  (assert= (list 0 1 3 5 7 9)
           (filter (compose-under or zero? odd?) (range 10))))
