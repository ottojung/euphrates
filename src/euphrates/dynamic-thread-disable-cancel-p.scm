
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-disable-cancel-p)
    :export (#{dynamic-thread-disable-cancel#p}#))))


(define dynamic-thread-disable-cancel#p
  (make-parameter #f))
