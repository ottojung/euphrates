
%run guile

%var sys-mutex-make

%for (COMPILER "guile")

(use-modules (srfi srfi-18))

(define sys-mutex-make (@ (srfi srfi-18) make-mutex))

%end
