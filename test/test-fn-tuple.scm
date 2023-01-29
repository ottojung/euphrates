
%run guile

%use (assert=) "./euphrates/assert-equal.scm"
%use (fn-tuple) "./euphrates/fn-tuple.scm"
%use (list-zip-with) "./euphrates/list-zip-with.scm"
%use (range) "./euphrates/range.scm"

(let () ;; fn-tuple
  (assert= '((0 2) (2 3) (4 4))
           (map (fn-tuple (lambda (x) (* x 2)) (lambda (x) (+ x 2)))
                (list-zip-with list (range 3) (range 3)))))
