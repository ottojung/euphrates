
%run guile

%for (COMPILER "guile")

(use-modules (srfi srfi-18))

%var dynamic-thread-mutex-make#p
(define dynamic-thread-mutex-make#p
  (make-parameter
   (@ (srfi srfi-18) make-mutex)))

%end
