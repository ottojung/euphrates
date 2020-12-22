
%run guile

%for (COMPILER "guile")

(use-modules (srfi srfi-18))

%var dynamic-thread-mutex-lock!#p
(define dynamic-thread-mutex-lock!#p
  (make-parameter mutex-lock!))

%end

