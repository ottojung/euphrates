
(cond-expand
 (guile
  (define-module (euphrates run-comprocess-p)
    :export (run-comprocess/p)
    :use-module ((euphrates run-comprocess-p-default) :select (run-comprocess/p-default)))))



(define run-comprocess/p
  (make-parameter run-comprocess/p-default))
