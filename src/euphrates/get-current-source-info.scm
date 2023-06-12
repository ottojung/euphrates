
(cond-expand
 (guile

  (define-syntax get-current-source-info
    (syntax-rules ()
      ((_ . args)
       (current-source-location))))

  ))
