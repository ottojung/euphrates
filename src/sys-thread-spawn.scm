
%run guile

%use (sys-thread set-sys-thread-handle!) "./sys-thread.scm"

%var sys-thread-spawn

%for (COMPILER "guile")

(use-modules (ice-9 threads))

(define (sys-thread-spawn thunk)
  (let ((th (sys-thread #f #f #t)))
    (set-sys-thread-handle!
     th
     (call-with-new-thread thunk))
    th))

%end
