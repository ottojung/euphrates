
%run guile

%use (string-split#simple) "./string-split-simple.scm"

%var lines

(define (lines str)
  (string-split#simple str #\newline))

