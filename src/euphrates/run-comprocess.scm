
(cond-expand
 (guile
  (define-module (euphrates run-comprocess)
    :export (run-comprocess)
    :use-module ((euphrates run-comprocess-p) :select (run-comprocess/p)))))



(define (run-comprocess . args)
  (apply (run-comprocess/p) args))
