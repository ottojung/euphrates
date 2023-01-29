
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-wait-delay-p)
    :export (#{dynamic-thread-wait-delay#us#p}#))))


(define dynamic-thread-wait-delay#us#p
  (make-parameter #f))
