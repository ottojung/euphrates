
%run guile

%use (assert=) "./src/assert-equal.scm"
%use (list-partition) "./src/list-partition.scm"
%use (range) "./src/range.scm"

(let () ;; list-partition
  (assert= '((#t 8 6 4 2 0)
             (#f 9 7 5 3 1))
           (list-partition even? (range 10))))
