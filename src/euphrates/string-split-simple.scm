
%run guile

%var string-split/simple

%for (COMPILER "guile")

(define string-split/simple string-split)

%end
%for (COMPILER "racket")

(define [string-split/simple str delim]
  (if (char? delim)
      (string-split str (string delim) #:trim? #f)
      (string-split str delim #:trim? #f)))

%end

