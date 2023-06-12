


(let () ;; random-variable-name
  (define n1 (random-variable-name 20))
  (assert= 20 (string-length n1))
  (assert= n1 (string-downcase n1))
  )
