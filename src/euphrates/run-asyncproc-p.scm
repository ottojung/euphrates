
(cond-expand
 (guile
  (define-module (euphrates run-asyncproc-p)
    :export (run-asyncproc/p)
    :use-module ((euphrates run-asyncproc-p-default) :select (run-asyncproc/p-default)))))



(define run-asyncproc/p
  (make-parameter run-asyncproc/p-default))
