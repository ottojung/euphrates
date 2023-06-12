
(cond-expand
 (guile

  (define-syntax get-current-source-file-path
    (syntax-rules ()
      ((_ . args)
       (cdr
        (assq
         'filename
         (current-source-location))))))

  )

 (racket

  (define-macro (get-current-source-file-path)
    '(path->string
      (build-path
       (this-expression-source-directory)
       (this-expression-file-name))))

  ))

