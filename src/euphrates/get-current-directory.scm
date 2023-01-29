
(cond-expand
 (guile
  (define-module (euphrates get-current-directory)
    :export (get-current-directory)
    :use-module ((euphrates current-directory-p) :select (current-directory/p)))))



(cond-expand
 (guile

  (define get-process-global-current-directory getcwd)

  )

 (racket

  (define (get-process-global-current-directory)
    (path->string (current-directory)))

  ))

(define (get-current-directory)
  (or (current-directory/p)
      (let ((cwd (get-process-global-current-directory)))
        (current-directory/p cwd)
        cwd)))
