
%run guile

%var get-current-directory

%for (COMPILER "guile")

(define get-current-directory getcwd)

%end

%for (COMPILER "racket")

(define (get-current-directory) (path->string (current-directory)))

%end
