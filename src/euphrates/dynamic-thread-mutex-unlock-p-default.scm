
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-mutex-unlock-p-default)
    :export (#{dynamic-thread-mutex-unlock!#p-default}#)
    :use-module ((euphrates np-thread) :select (np-thread-global-mutex-unlock!)))))



(define dynamic-thread-mutex-unlock!#p-default
  (lambda _ 0))
