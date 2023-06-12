


(let () ;; fn
  (assert= (list 1 2 3)
           ((fn list 1 % 3) 2)))
