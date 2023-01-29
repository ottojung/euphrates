
(cond-expand
 (guile
  (define-module (euphrates sys-thread-current-p-default)
    :export (#{sys-thread-current#p-default}#)
    :use-module ((euphrates sys-thread-obj) :select (sys-thread-obj)))))



(define sys-thread-current#p-default
  (sys-thread-obj #f #f #f))
