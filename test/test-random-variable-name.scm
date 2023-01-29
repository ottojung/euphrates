
(cond-expand
 (guile
  (define-module (test-random-variable-name)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates random-variable-name) :select (random-variable-name)))))


(let () ;; random-variable-name
  (define n1 (random-variable-name 20))
  (assert= 20 (string-length n1))
  (assert= n1 (string-downcase n1))
  )
