

;; list-break

(let ()
  (define-values (a1 a2)
    (list-break even? '(3 5 7 2 1 9)))

  (assert= a1 '(3 5 7))
  (assert= a2 '(2 1 9)))
