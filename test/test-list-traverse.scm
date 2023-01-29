
(cond-expand
 (guile
  (define-module (test-list-traverse)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates list-traverse) :select (list-traverse))
    :use-module ((euphrates range) :select (range)))))

;; list-traverse

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
