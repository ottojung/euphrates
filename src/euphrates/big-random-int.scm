



(define big-random-int
  (lambda (max)
    ((random-source-make-integers
      (get-current-random-source)) max)))
