
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-mutex-make-p)
    :export (#{dynamic-thread-mutex-make#p}#))))


(define dynamic-thread-mutex-make#p
  (make-parameter #f))
