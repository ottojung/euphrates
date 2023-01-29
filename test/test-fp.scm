
%run guile

%use (assert=) "./euphrates/assert-equal.scm"
%use (fp) "./euphrates/fp.scm"
%use (list-zip-with) "./euphrates/list-zip-with.scm"
%use (range) "./euphrates/range.scm"

(let () ;; fp
  (assert= '((0 2) (2 3) (4 4))
           (map (fp (x y) (list (* x 2) (+ y 2)))
                (list-zip-with list (range 3) (range 3)))))
