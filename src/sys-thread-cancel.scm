
%run guile

%var sys-thread-cancel

%use (set-sys-thread-cancel-scheduled?!) "./sys-thread.scm"

(define (sys-thread-cancel th)
  (set-sys-thread-cancel-scheduled?! th #t))
