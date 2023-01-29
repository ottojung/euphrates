
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-yield-p-default)
    :export (#{dynamic-thread-yield#p-default}#)
    :use-module ((euphrates np-thread) :select (np-thread-global-yield)))))



(define dynamic-thread-yield#p-default
  (lambda _ 0))
