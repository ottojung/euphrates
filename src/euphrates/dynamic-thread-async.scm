
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-async)
    :export (dynamic-thread-async)
    :use-module ((euphrates dynamic-thread-async-thunk) :select (dynamic-thread-async-thunk)))))



(define-syntax dynamic-thread-async
  (syntax-rules ()
    ((_ . bodies)
     (dynamic-thread-async-thunk (lambda _ . bodies)))))

