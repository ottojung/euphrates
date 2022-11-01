
%run guile

%use (assert=) "./src/assert-equal.scm"
%use (string->seconds) "./src/string-to-seconds.scm"

(let () ;; string->seconds
  (assert= 20 (string->seconds "20s"))
  (assert= 80 (string->seconds "1m20s"))
  (assert= (+ (* 2 60 60) (* 1 60) (* 20 1))
           (string->seconds "2h1m20s"))
  (assert= (+ (* 2 60 60) (* 1 60) (* 20 1))
           (string->seconds "2h1m20s"))
  (assert= (+ (* 2 60 60) (* 1 60) (* 20 1))
           (string->seconds "1m2h20s"))
  (assert= (+ (* 3 60 60) (* 2 60 60) (* 1 60) (* 20 1))
           (string->seconds "1m3h2h20s"))
  (assert= (+ (* 3 60 60) (* 2.5 60 60) (* 1 60) (* 20 1))
           (string->seconds "1m3h2.5h20s"))
  )
