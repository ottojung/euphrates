


(cond-expand
 (guile

  (define file-or-directory-exists? file-exists?)

  )

 (racket

  (define [file-or-directory-exists? path]
    (or (file-exists? path)
    (directory-exists? path)))

  ))

