
%run guile

;; list-traverse
%use (assert=) "./euphrates/assert-equal.scm"
%use (list-traverse) "./euphrates/list-traverse.scm"
%use (range) "./euphrates/range.scm"

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
