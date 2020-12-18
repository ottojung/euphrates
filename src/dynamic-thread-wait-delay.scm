
%run guile

%use (dynamic-thread-wait-delay#us#p-default) "./dynamic-thread-wait-delay-default.scm"

%var dynamic-thread-wait-delay#us#p

(define dynamic-thread-wait-delay#us#p
  (make-parameter dynamic-thread-wait-delay#us#p-default))
