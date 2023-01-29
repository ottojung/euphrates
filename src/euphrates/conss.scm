
%run guile

%var conss

%for (COMPILER "guile")

(define conss cons*)

%end

%for (COMPILER "racket")

(define conss list*)

%end
