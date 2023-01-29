
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-mutex-make-p-default)
    :export (#{dynamic-thread-mutex-make#p-default}#)
    :use-module ((euphrates np-thread) :select (np-thread-global-mutex-make)))))



(define dynamic-thread-mutex-make#p-default
  (lambda _ 0))
