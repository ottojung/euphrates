
%run guile

%var run-comprocess/p

%use (run-comprocess/p-default) "./run-comprocess-p-default.scm"

(define run-comprocess/p
  (make-parameter run-comprocess/p-default))
