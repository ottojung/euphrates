
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-mutex-lock-p)
    :export (#{dynamic-thread-mutex-lock!#p}#))))


(define dynamic-thread-mutex-lock!#p
  (make-parameter #f))
