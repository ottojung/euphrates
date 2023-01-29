
(cond-expand
 (guile
  (define-module (test-number-list)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates fp) :select (fp))
    :use-module ((euphrates number-list) :select (number->number-list number-list->number)))))

;; number-list

(let ()
  (assert= 9 (number-list->number 2 '(1 0 0 1) '()))
  (assert= 8 (number-list->number 2 '(1 0 0 0) '()))

  (assert= 0.375
           (exact->inexact (number-list->number 2 '(0 0 0 0) '(0 1 1))))
  (assert= 0.375
           (exact->inexact (number-list->number 2 '() '(0 1 1))))
  (assert= 9.375
           (exact->inexact (number-list->number 2 '(1 0 0 1) '(0 1 1))))
  (assert= 8.375
           (exact->inexact (number-list->number 2 '(1 0 0 0) '(0 1 1))))

  (let ()
    (define-values (wp fp) (number->number-list 2 9))
    (assert= wp '(1 0 0 1))
    (assert= fp '()))
  (let ()
    (define-values (wp fp) (number->number-list 2 8))
    (assert= wp '(1 0 0 0))
    (assert= fp '()))
  (let ()
    (define-values (wp fp) (number->number-list 2 0.375))
    (assert= wp '())
    (assert= fp '(0 1 1)))
  (let ()
    (define-values (wp fp) (number->number-list 2 9.375))
    (assert= wp '(1 0 0 1))
    (assert= fp '(0 1 1)))
  (let ()
    (define-values (wp fp) (number->number-list 2 8.375))
    (assert= wp '(1 0 0 0))
    (assert= fp '(0 1 1)))
  )
