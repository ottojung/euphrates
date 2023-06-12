


(cond-expand
 (guile

  (define [file-mtime filepath]
    (stat:mtime (stat filepath)))

  ))

