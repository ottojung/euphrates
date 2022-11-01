
%run guile

%use (assert=) "./src/assert-equal.scm"
%use (list-zip-with) "./src/list-zip-with.scm"

(let () ;; list-zip-with
  (assert= '((1 a) (2 b) (3 c))
           (list-zip-with list '(1 2 3) '(a b c)))
  (assert= '((1 a) (2 b))
           (list-zip-with list '(1 2 3) '(a b)))
  (assert= '((1 a) (2 b))
           (list-zip-with list '(1 2) '(a b)))
  (assert= '((1 a) (2 b))
           (list-zip-with list '(1 2) '(a b c)))
  (assert= '()
           (list-zip-with list '() '(a b c)))
  )
