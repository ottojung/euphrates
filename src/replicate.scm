
%run guile

%var replicate

(define (replicate n x)
  (if (= 0 n)
      (list)
      (cons x (replicate (- n 1) x))))
