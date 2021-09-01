
%run guile

%var sys-mutex-unlock!

%for (COMPILER "guile")

(use-modules (srfi srfi-18))

(define sys-thread-mutex-unlock!#p mutex-unlock!)

%end
