

;; list-levenshtein-distance

(let ()
  (define (test n a b)
    (assert= n (list-levenshtein-distance
                (string->list a)
                (string->list b))))

  (test 1 "kitten" "sitten")
  (test 1 "sitten" "sittin")
  (test 1 "sittin" "sitting")
  (test 2 "kitten" "sittin")
  (test 2 "sitten" "sitting")
  (test 3 "kitten" "sitting")
  )
