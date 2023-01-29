
%run guile

%var lines->string

(define (lines->string lns)
  (string-join lns "\n"))

