


(define-syntax with-critical
  (syntax-rules ()
    ((_ critical-func . bodies)
     (critical-func
      (lambda [] . bodies)))))


