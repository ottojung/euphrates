
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-mutex-lock-p-default)
    :export (#{dynamic-thread-mutex-lock!#p-default}#)
    :use-module ((euphrates np-thread) :select (np-thread-global-mutex-lock!)))))



(define dynamic-thread-mutex-lock!#p-default
  (lambda _ 0))
