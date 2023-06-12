
(define-syntax with-ignore-errors!
  (syntax-rules ()
    ((_ . bodies)
     (catch-any
      (lambda _ . bodies)
      (lambda errors
        (debug "~aerror: ~s"
               (current-source-info->string
                (get-current-source-info))
               errors))))))
