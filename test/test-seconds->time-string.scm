
(cond-expand
 (guile
  (define-module (test-seconds->time-string)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates time-to-string) :select (seconds->time-string)))))

;; seconds->time-string

(let ()
  (assert= "2:01:10" (seconds->time-string (+ (* 3600 2) 70))))
