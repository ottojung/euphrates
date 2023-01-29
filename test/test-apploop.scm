
%run guile

;; apploop
%use (apploop) "./euphrates/apploop.scm"
%use (assert=) "./euphrates/assert-equal.scm"

(let ()
  (assert=
   120
   (apploop [x] [5] (if (= 0 x) 1 (* x (loop (- x 1)))))))
