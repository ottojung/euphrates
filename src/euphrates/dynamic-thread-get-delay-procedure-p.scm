
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-get-delay-procedure-p)
    :export (#{dynamic-thread-get-delay-procedure#p}#))))


(define dynamic-thread-get-delay-procedure#p
  (make-parameter #f))
