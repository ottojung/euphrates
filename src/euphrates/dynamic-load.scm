
(cond-expand
 (guile
  (define-module (euphrates dynamic-load)
    :declarative? #f
    :export (dynamic-load))))


(define (dynamic-load filepath)
  (load filepath))
