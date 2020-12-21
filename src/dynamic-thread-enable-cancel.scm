
%run guile

%use (sys-thread-enable-cancel) "./sys-thread-enable-cancel.scm"

%var dynamic-thread-enable-cancel#p
%var dynamic-thread-enable-cancel

(define dynamic-thread-enable-cancel#p
  (make-parameter sys-thread-enable-cancel))
(define (dynamic-thread-enable-cancel)
  ((dynamic-thread-enable-cancel#p)))


