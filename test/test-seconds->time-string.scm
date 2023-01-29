
%run guile

;; seconds->time-string
%use (assert=) "./euphrates/assert-equal.scm"
%use (seconds->time-string) "./euphrates/time-to-string.scm"

(let ()
  (assert= "2:01:10" (seconds->time-string (+ (* 3600 2) 70))))
