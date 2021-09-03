
%run guile

%use (string-split/simple) "./string-split-simple.scm"

%var string->lines

(define (string->lines str)
  (string-split/simple str #\newline))

