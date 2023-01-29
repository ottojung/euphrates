
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-sleep-p)
    :export (#{dynamic-thread-sleep#p}#))))


(define dynamic-thread-sleep#p
  (make-parameter #f))
