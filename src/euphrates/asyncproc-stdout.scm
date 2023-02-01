
(cond-expand
 (guile
  (define-module (euphrates asyncproc-stdout)
    :export (asyncproc-stdout))))


(define asyncproc-stdout
  (make-parameter #f))
