

;; seconds->time-string

(let ()
  (assert= "2:01:10" (seconds->time-string (+ (* 3600 2) 70))))
