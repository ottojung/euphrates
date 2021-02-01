
%run guile

%var system*/exit-code

%for (COMPILER "guile")

(define system*/exit-code system*)

%end
%for (COMPILER "racket")

(define system*/exit-code system*/exit-code)

%end
