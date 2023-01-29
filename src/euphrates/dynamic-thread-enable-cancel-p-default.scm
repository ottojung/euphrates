
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-enable-cancel-p-default)
    :export (#{dynamic-thread-enable-cancel#p-default}#)
    :use-module ((euphrates np-thread) :select (np-thread-global-enable-cancel)))))



(define dynamic-thread-enable-cancel#p-default
  (lambda _ 0))
