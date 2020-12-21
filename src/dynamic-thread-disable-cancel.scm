
%run guile

%use (sys-thread-disable-cancel) "./sys-thread-disable-cancel.scm"

%var dynamic-thread-disable-cancel#p
%var dynamic-thread-disable-cancel

(define dynamic-thread-disable-cancel#p
  (make-parameter sys-thread-disable-cancel))
(define (dynamic-thread-disable-cancel)
  ((dynamic-thread-disable-cancel#p)))


