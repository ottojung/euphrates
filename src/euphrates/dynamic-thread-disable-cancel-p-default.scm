
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-disable-cancel-p-default)
    :export (#{dynamic-thread-disable-cancel#p-default}#)
    :use-module ((euphrates np-thread) :select (np-thread-global-disable-cancel)))))



(define dynamic-thread-disable-cancel#p-default
  (lambda _ 0))
