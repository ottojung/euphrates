



(define-syntax dynamic-thread-async
  (syntax-rules ()
    ((_ . bodies)
     (dynamic-thread-async-thunk (lambda _ . bodies)))))

