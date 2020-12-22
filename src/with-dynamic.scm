
%run guile

%var with-dynamic

(define-syntax-rule (%with-dynamic-helper1 arg value . bodies)
  (if (parameter? arg)
      (parameterize ((arg value)) . bodies)
      (arg (lambda _ value) (lambda _ . bodies))))

(define-syntax with-dynamic
  (syntax-rules ()
    ((_ ((arg value)) . bodies)
     (%with-dynamic-helper1 arg value . bodies))
    ((_ ((arg value) . rest) . bodies)
     (%with-dynamic-helper1
      arg value
      (with-dynamic rest . bodies)))))
