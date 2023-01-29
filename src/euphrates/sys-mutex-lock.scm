
%run guile

%var sys-mutex-lock!

%for (COMPILER "guile")

(use-modules (srfi srfi-18))

(define sys-mutex-lock! mutex-lock!)

%end
