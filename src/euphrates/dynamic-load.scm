
(cond-expand
 (guile-3
  (define-module (euphrates dynamic-load)
    :declarative? #f
    :export (dynamic-load)))
 (guile
  (define-module (euphrates dynamic-load)
    :export (dynamic-load))))


(define (dynamic-load filepath)
  (load filepath))
