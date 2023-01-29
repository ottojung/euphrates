
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-spawn-p)
    :export (#{dynamic-thread-spawn#p}#))))


(define dynamic-thread-spawn#p
  (make-parameter #f))
