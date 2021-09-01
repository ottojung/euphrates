
%run guile

%var sys-usleep

%for (COMPILER "guile")

(define sys-usleep usleep)

%end
%for (COMPILER "racket")

(define (sys-usleep microsecond)
  (sleep (/ microsecond 1000000)))

%end
