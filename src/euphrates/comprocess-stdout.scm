
(cond-expand
 (guile
  (define-module (euphrates comprocess-stdout)
    :export (comprocess-stdout))))


(define comprocess-stdout
  (make-parameter #f))
