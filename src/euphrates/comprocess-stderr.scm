
(cond-expand
 (guile
  (define-module (euphrates comprocess-stderr)
    :export (comprocess-stderr))))


(define comprocess-stderr
  (make-parameter #f))
