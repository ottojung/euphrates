
(cond-expand
 (guile
  (define-module (euphrates get-current-source-info)
    :export (get-current-source-info))))


(cond-expand
 (guile

  (define-syntax-rule [get-current-source-info]
    (current-source-location))

  ))

