
%run guile

;; list-traverse
%use (assert=) "./src/assert-equal.scm"
%use (list-traverse) "./src/list-traverse.scm"
%use (range) "./src/range.scm"

(let ()
  (assert=
   6
   (list-traverse
    (range 10)
    (lambda (x xs)
      (if (< 5 x)
          (values #f x)
          (values #t xs)))))

  (assert=
   'custom-default
   (list-traverse
    (range 10)
    'custom-default
    (lambda (x xs)
      (if (< 5 x)
          (values #f x)
          (values #t (list)))))))
