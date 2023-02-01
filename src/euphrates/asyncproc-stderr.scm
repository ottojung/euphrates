
(cond-expand
 (guile
  (define-module (euphrates asyncproc-stderr)
    :export (asyncproc-stderr))))


(define asyncproc-stderr
  (make-parameter #f))
