
%run guile

%for (COMPILER "guile")

(use-modules (srfi srfi-18))

%var dynamic-thread-mutex-unlock!#p
(define dynamic-thread-mutex-unlock!#p
  (make-parameter mutex-unlock!))

%end

