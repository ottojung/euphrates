
%run guile

%use (assert=) "./euphrates/assert-equal.scm"
%use (fn) "./euphrates/fn.scm"

(let () ;; fn
  (assert= (list 1 2 3)
           ((fn list 1 % 3) 2)))
