
%run guile

%use (sys-thread) "./sys-thread-obj.scm"

%var sys-thread-current

(define sys-thread-current
  (make-parameter
   (sys-thread #f #f #f)))
