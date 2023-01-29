
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-enable-cancel-p)
    :export (#{dynamic-thread-enable-cancel#p}#))))


(define dynamic-thread-enable-cancel#p
  (make-parameter #f))
