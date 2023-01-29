
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-mutex-unlock-p)
    :export (#{dynamic-thread-mutex-unlock!#p}#))))


(define dynamic-thread-mutex-unlock!#p
  (make-parameter #f))
