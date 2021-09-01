
%run guile

%var sys-mutex-lock!

%for (COMPILER "guile")

(use-modules (srfi srfi-18))

(define sys-thread-mutex-lock!#p mutex-lock!)

%end
