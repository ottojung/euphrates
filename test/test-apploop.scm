
%run guile

;; apploop
%use (apploop) "./src/apploop.scm"
%use (assert=) "./src/assert-equal.scm"

(let ()
  (assert=
   120
   (apploop [x] [5] (if (= 0 x) 1 (* x (loop (- x 1)))))))
