
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-wait-delay-p-default)
    :export (#{dynamic-thread-wait-delay#us#p-default}#))))


(define dynamic-thread-wait-delay#us#p-default
  50000) ;; 50 milliseconds
