
(cond-expand
  (guile)
  ((not guile)
   (import
     (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates list-group-by) list-group-by))
   (import
     (only (scheme base)
           begin
           cond-expand
           even?
           lambda
           let
           modulo
           quote))))



(assert= '((1 7))
         (list-group-by (lambda (x) (modulo x 3)) '(7)))
(assert= '((1 7 7 7 7))
         (list-group-by (lambda (x) (modulo x 3)) '(7 7 7 7)))
(assert= '((1 4 7 7 4 7 7))
         (list-group-by (lambda (x) (modulo x 3)) '(4 7 7 4 7 7)))
(assert= '((#f 1 3 5) (#t 2 4))
         (list-group-by even? '(1 2 3 4 5)))
(assert= '((1 1 4) (2 2 5) (0 3))
         (list-group-by (lambda (x) (modulo x 3)) '(1 2 3 4 5)))
(assert= '()
         (list-group-by (lambda (x) (modulo x 3)) '()))
