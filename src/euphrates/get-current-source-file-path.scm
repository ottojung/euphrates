
(cond-expand
 (guile
  (define-module (euphrates get-current-source-file-path)
    :export (get-current-source-file-path))))


(cond-expand
 (guile

  (define-syntax-rule [get-current-source-file-path]
    (cdr
     (assq
      'filename
      (current-source-location))))

  ))

(cond-expand
 (racket

  (define-macro (get-current-source-file-path)
    '(path->string
      (build-path
       (this-expression-source-directory)
       (this-expression-file-name))))

  ))

