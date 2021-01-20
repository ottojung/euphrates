
%run guile

%var curry-if

(define curry-if
  (case-lambda
   ((test-function then-function)
    (curry-if test-function then-function identity))
   ((test-function then-function else-function)
    (lambda (x)
      (if (test-function x) (then-function x) (else-function x))))))

