
(cond-expand
 (guile
  (define-module (euphrates run-asyncproc)
    :export (run-asyncproc)
    :use-module ((euphrates run-asyncproc-p) :select (run-asyncproc/p)))))



(define (run-asyncproc . args)
  (apply (run-asyncproc/p) args))
