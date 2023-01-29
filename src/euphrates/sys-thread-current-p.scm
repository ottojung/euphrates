
(cond-expand
 (guile
  (define-module (euphrates sys-thread-current-p)
    :export (#{sys-thread-current#p}#))))


(define sys-thread-current#p
  (make-parameter #f))

