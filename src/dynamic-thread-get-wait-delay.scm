
%run guile

%use (dynamic-thread-wait-delay#us#p-default) "./dynamic-thread-wait-delay-p-default.scm"
%use (dynamic-thread-wait-delay#us#p) "./dynamic-thread-wait-delay-p.scm"

%var dynamic-thread-get-wait-delay

(define (dynamic-thread-get-wait-delay)
  (or (dynamic-thread-wait-delay#us#p)
      dynamic-thread-wait-delay#us#p-default))
