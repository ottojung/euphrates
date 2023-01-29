
(cond-expand
 (guile
  (define-module (euphrates file-or-directory-exists-q)
    :export (file-or-directory-exists?))))


(cond-expand
 (guile

  (define file-or-directory-exists? file-exists?)

  ))

(cond-expand
 (racket

  (define [file-or-directory-exists? path]
    (or (file-exists? path)
    (directory-exists? path)))

  ))

