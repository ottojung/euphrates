
(cond-expand
 (guile
  (define-module (test-list-levenshtein-distance)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates list-levenshtein-distance) :select (list-levenshtein-distance)))))

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
