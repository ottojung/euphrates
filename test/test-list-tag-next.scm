

;; list-tag/next

(let ()
  (assert= '((#f 1 3 5) (2 7 9) (6 1 3))
           (list-tag/next #f even? '(1 3 5 2 7 9 6 1 3)))
  (assert= '(#f 2 6)
           (map car (list-tag/next #f even? '(1 3 5 2 7 9 6 1 3))))

  (assert= '((#f 1 3 5) (2 7 9) (6))
           (list-tag/next #f even? '(1 3 5 2 7 9 6)))
  (assert= '(#f 2 6)
           (map car (list-tag/next #f even? '(1 3 5 2 7 9 6))))

  (assert= '((4 1 3 5) (2 7 9) (6 1 3))
           (list-tag/next #f even? '(4 1 3 5 2 7 9 6 1 3)))
  (assert= '(4 2 6)
           (map car (list-tag/next #f even? '(4 1 3 5 2 7 9 6 1 3))))

  (assert= '((4 1 3 5) (2 7 9) (6))
           (list-tag/next #f even? '(4 1 3 5 2 7 9 6)))
  (assert= '(4 2 6)
           (map car (list-tag/next #f even? '(4 1 3 5 2 7 9 6))))

  (assert= '((#f))
           (list-tag/next #f even? '()))

  (assert= '((#f 1 3 5 7))
           (list-tag/next #f even? '(1 3 5 7)))

  (assert= '(1 3 5 2 7 9 6 1 3)
           (list-untag/next (list-tag/next #f even? '(1 3 5 2 7 9 6 1 3))))
  (assert= '()
           (list-untag/next (list-tag/next #f even? '())))

  )
