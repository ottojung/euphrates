
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-critical-make-p)
    :export (#{dynamic-thread-critical-make#p}#))))


(define dynamic-thread-critical-make#p
  (make-parameter #f))
