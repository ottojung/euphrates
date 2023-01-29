
%run guile

%use (dynamic-thread-enable-cancel#p) "./dynamic-thread-enable-cancel-p.scm"
%use (dynamic-thread-enable-cancel#p-default) "./dynamic-thread-enable-cancel-p-default.scm"
%var dynamic-thread-enable-cancel

(define (dynamic-thread-enable-cancel)
  ((or (dynamic-thread-enable-cancel#p)
       dynamic-thread-enable-cancel#p-default)))


