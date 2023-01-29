
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-sleep-p-default)
    :export (#{dynamic-thread-sleep#p-default}#)
    :use-module ((euphrates sys-usleep) :select (sys-usleep)))))



(define dynamic-thread-sleep#p-default
  sys-usleep)

