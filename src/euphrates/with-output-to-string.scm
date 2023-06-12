
(define-syntax with-output-to-string
  (syntax-rules ()
    ((_ . bodies)
     (let ((q (open-output-string)))
       (parameterize ((current-output-port q))
         (let () . bodies))
       (let ((r (get-output-string q)))
         (close-port q)
         r)))))
