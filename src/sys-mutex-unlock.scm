
%run guile

%var sys-mutex-unlock!

%for (COMPILER "guile")

(use-modules (srfi srfi-18))

(define sys-mutex-unlock! mutex-unlock!)

%end
