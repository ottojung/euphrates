
%run guile

%use (dynamic-thread-async-thunk) "./dynamic-thread-async-thunk.scm"

(define-syntax-rule (dynamic-thread-async . bodies)
  (dynamic-thread-async-thunk (lambda _ . bodies)))

