
%run guile

%use (dynamic-thread-disable-cancel#p) "./dynamic-thread-disable-cancel-p.scm"
%use (dynamic-thread-disable-cancel#p-default) "./dynamic-thread-disable-cancel-p-default.scm"

%var dynamic-thread-disable-cancel

(define (dynamic-thread-disable-cancel)
  ((or (dynamic-thread-disable-cancel#p)
       dynamic-thread-disable-cancel#p-default)))


