
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-critical-make-p-default)
    :export (#{dynamic-thread-critical-make#p-default}#)
    :use-module ((euphrates np-thread) :select (np-thread-global-critical-make)))))



(define dynamic-thread-critical-make#p-default
  (lambda () (lambda (section) (section))))
