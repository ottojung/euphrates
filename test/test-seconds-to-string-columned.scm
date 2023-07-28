
(cond-expand
  (guile)
  (else (import (only (euphrates assert-equal) assert=))
        (import
          (only (euphrates seconds-to-string-columned)
                seconds->string-columned))
        (import
          (only (scheme base) * + begin cond-expand not))))

(assert= "10:40:20"
         (seconds->string-columned
          (+ (* 10 60 60) (* 40 60) (* 20 1))))

(assert= "02:03:20"
         (seconds->string-columned
          (+ (* 2 60 60) (* 3 60) (* 20 1))))

(assert= "01:20"
         (seconds->string-columned
          (+ (* 1 60) (* 20 1))))

(assert= "20"
         (seconds->string-columned
          (+ (* 20 1))))

(assert= "50:02:03:20"
         (seconds->string-columned
          (+ (* 50 24 60 60) (* 2 60 60) (* 3 60) (* 20 1))))

(assert= "90:02:03:20"
         (seconds->string-columned
          (+ (* 90 24 60 60) (* 2 60 60) (* 3 60) (* 20 1))))

(assert= "9:02:03:20"
         (seconds->string-columned
          (+ (* 9 24 60 60) (* 2 60 60) (* 3 60) (* 20 1))))

(assert= "9:00:03:20"
         (seconds->string-columned
          (+ (* 9 24 60 60) (* 0 0) (* 3 60) (* 20 1))))

(assert= "9:00:00:20"
         (seconds->string-columned
          (+ (* 9 24 60 60) (* 0 0) (* 0 60) (* 20 1))))

(assert= "9:00:00:00"
         (seconds->string-columned
          (+ (* 9 24 60 60) (* 0 0) (* 0 60) (* 0 1))))

(assert= "9:00:23:00"
         (seconds->string-columned
          (+ (* 9 24 60 60) (* 0 0) (* 23 60) (* 0 1))))

(assert= "9:00:23:30.5"
         (seconds->string-columned
          (+ (* 9 24 60 60) (* 0 0) (* 23 60) (* 30 1) 1/2)))

(assert= "9:00:23:00.5"
         (seconds->string-columned
          (+ (* 9 24 60 60) (* 0 0) (* 23 60) (* 0 1) 1/2)))

(assert= "23:00.5"
         (seconds->string-columned
          (+ (* 0 24 60 60) (* 0 0) (* 23 60) (* 0 1) 1/2)))

(assert= "00" (seconds->string-columned 0))
(assert= "01" (seconds->string-columned 1))
(assert= "15" (seconds->string-columned 15.0))
(assert= "05" (seconds->string-columned 5.0))
