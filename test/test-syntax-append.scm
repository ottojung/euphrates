
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates syntax-append) syntax-append))
   (import
     (only (scheme base)
           _
           begin
           cond-expand
           define-syntax
           let
           list
           quote
           syntax-rules))))



(let ()
  (define-syntax cont
    (syntax-rules () ((_ arg buf) (list arg . buf))))

  (assert= (list 'arg 2 3 4 5 6 7)
           (syntax-append (cont 'arg) (2 3) (4 5 6 7))))

(let ()
  (define-syntax cont
    (syntax-rules () ((_ arg buf) (list arg . buf))))

  (assert= (list 'arg 1 2 3 4 5 6 7 8 9)
           (syntax-append (cont 'arg) (1 2 3) (4 5 6 7) (8 9))))

(let ()
  (define-syntax cont
    (syntax-rules () ((_ arg buf) (list arg . buf))))

  (assert= (list 'arg 1 2 3 4 5 6 7 8 9)
           (syntax-append (cont 'arg) (1 2 3) (4 5) (6 7) (8 9))))
