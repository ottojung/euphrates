
%run guile

%use (dynamic-thread-async-thunk) "./dynamic-thread-async-thunk.scm"

(define-syntax dynamic-thread-async
  (syntax-rules ()
    ((_ . bodies)
     (dynamic-thread-async-thunk (lambda _ . bodies)))))

