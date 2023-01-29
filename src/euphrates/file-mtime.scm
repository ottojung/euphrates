
(cond-expand
 (guile
  (define-module (euphrates file-mtime)
    :export (file-mtime))))


(cond-expand
 (guile

  (define [file-mtime filepath]
    (stat:mtime (stat filepath)))

  ))

