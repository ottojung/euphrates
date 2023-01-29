
%run guile

%var run-comprocess

%use (run-comprocess/p) "./run-comprocess-p.scm"

(define (run-comprocess . args)
  (apply (run-comprocess/p) args))
