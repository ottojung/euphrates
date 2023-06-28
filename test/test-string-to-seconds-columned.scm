


(assert= (+ (* 2 60 60) (* 1 60) (* 20 1))
         (string->seconds/columned "2:1:20"))

(assert= (+ (* 2 60 60) (* 1 60) (* 20 1))
         (string->seconds/columned "02:01:20"))

(assert= (+ (* 2 60 60) (* 1 60) (* 20.341 1))
         (string->seconds/columned "02:01:20.341"))

(assert= (+ (* 50 24 60 60) (* 2 60 60) (* 1 60) (* 20.341 1))
         (string->seconds/columned "50:02:01:20.341"))
