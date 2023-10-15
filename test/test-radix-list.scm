
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates fp) fp))
   (import
     (only (euphrates radix-list)
           number->radix-list
           radix-list->number))
   (import
     (only (scheme base)
           begin
           cond-expand
           define-values
           let
           quote))
   (import (only (scheme r5rs) exact->inexact))))


;; radix-list

(let ()
  (assert= 9 (radix-list->number 2 '(1 0 0 1) '()))
  (assert= 8 (radix-list->number 2 '(1 0 0 0) '()))

  (assert= 0.375
           (exact->inexact (radix-list->number 2 '(0 0 0 0) '(0 1 1))))
  (assert= 0.375
           (exact->inexact (radix-list->number 2 '() '(0 1 1))))
  (assert= 9.375
           (exact->inexact (radix-list->number 2 '(1 0 0 1) '(0 1 1))))
  (assert= 8.375
           (exact->inexact (radix-list->number 2 '(1 0 0 0) '(0 1 1))))

  (let ()
    (define-values (wp fp) (number->radix-list 2 9))
    (assert= wp '(1 0 0 1))
    (assert= fp '()))
  (let ()
    (define-values (wp fp) (number->radix-list 2 8))
    (assert= wp '(1 0 0 0))
    (assert= fp '()))
  (let ()
    (define-values (wp fp) (number->radix-list 2 0.375))
    (assert= wp '())
    (assert= fp '(0 1 1)))
  (let ()
    (define-values (wp fp) (number->radix-list 2 9.375))
    (assert= wp '(1 0 0 1))
    (assert= fp '(0 1 1)))
  (let ()
    (define-values (wp fp) (number->radix-list 2 8.375))
    (assert= wp '(1 0 0 0))
    (assert= fp '(0 1 1)))
  )
