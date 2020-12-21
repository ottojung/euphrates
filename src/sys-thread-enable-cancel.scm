
%run guile

%use (set-sys-thread-cancel-enabled?!) "./sys-thread.scm"
%use (sys-thread-current) "./sys-thread-current.scm"

%var sys-thread-enable-cancel

(define (sys-thread-enable-cancel)
  (let ((me (sys-thread-current)))
    (set-sys-thread-cancel-enabled?! me #t)))

