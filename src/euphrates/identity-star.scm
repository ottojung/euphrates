
(cond-expand
 (guile
  (define-module (euphrates identity-star)
    :export (identity*))))


(define (identity* . args)
  (apply values args))
