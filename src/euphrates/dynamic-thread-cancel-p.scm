
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-cancel-p)
    :export (#{dynamic-thread-cancel#p}#))))


(define dynamic-thread-cancel#p
  (make-parameter #f))
