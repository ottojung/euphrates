
%run guile

%var sys-thread-current#p-default

%use (sys-thread-obj) "./sys-thread-obj.scm"

(define sys-thread-current#p-default
  (sys-thread-obj #f #f #f))
