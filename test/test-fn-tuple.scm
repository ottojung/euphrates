
%run guile

%use (assert=) "./src/assert-equal.scm"
%use (fn-tuple) "./src/fn-tuple.scm"
%use (list-zip-with) "./src/list-zip-with.scm"
%use (range) "./src/range.scm"

(let () ;; fn-tuple
  (assert= '((0 2) (2 3) (4 4))
           (map (fn-tuple (lambda (x) (* x 2)) (lambda (x) (+ x 2)))
                (list-zip-with list (range 3) (range 3)))))
