
%run guile

%use (set-sys-thread-cancel-enabled?!) "./sys-thread.scm"
%use (sys-thread-current) "./sys-thread-current.scm"

%var sys-thread-disable-cancel

(define (sys-thread-disable-cancel)
  (let ((me (sys-thread-current)))
    (set-sys-thread-cancel-enabled?! me #f)))

