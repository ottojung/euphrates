
%run guile

%use (assert=) "./src/assert-equal.scm"
%use (fn-pair) "./src/fn-pair.scm"
%use (list-zip-with) "./src/list-zip-with.scm"
%use (range) "./src/range.scm"

(assert= '((0 . 2) (2 . 3) (4 . 4))
         (map (fn-pair (a b) (cons (* a 2) (+ b 2)))
              (list-zip-with cons (range 3) (range 3))))
