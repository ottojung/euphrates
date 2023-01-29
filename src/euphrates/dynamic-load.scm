
(cond-expand
 (guile
  (define-module (euphrates dynamic-load)
    :export (dynamic-load))))


(define (dynamic-load filepath)
  (load filepath))
