
%run guile

%use (assert=) "./euphrates/assert-equal.scm"
%use (compose-under) "./euphrates/compose-under.scm"
%use (range) "./euphrates/range.scm"

(let () ;; compose-under
  (assert= (list 10 25 0)
           ((compose-under list + * -) 5 5))
  (assert= (list 0 1 3 5 7 9)
           (filter (compose-under or zero? odd?) (range 10))))
