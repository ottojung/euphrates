
(cond-expand
 (guile
  (define-module (test-string-to-seconds-columned)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates string-to-seconds-columned) :select (string->seconds/columned))
    :use-module ((euphrates string-to-seconds) :select (string->seconds)))))


(let () ;; string-to-seconds-columned
  (assert= 20 (string->seconds "20s"))
  (assert= 80 (string->seconds "1m20s"))
  (assert= (+ (* 2 60 60) (* 1 60) (* 20 1))
           (string->seconds/columned "2:1:20"))
  (assert= (+ (* 2 60 60) (* 1 60) (* 20 1))
           (string->seconds/columned "02:01:20"))
  (assert= (+ (* 2 60 60) (* 1 60) (* 20.341 1))
           (string->seconds/columned "02:01:20.341"))
  (assert= (+ (* 50 24 60 60) (* 2 60 60) (* 1 60) (* 20.341 1))
           (string->seconds/columned "50:02:01:20.341"))
  )
