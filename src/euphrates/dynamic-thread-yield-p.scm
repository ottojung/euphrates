
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-yield-p)
    :export (#{dynamic-thread-yield#p}#))))


;; This yield should also be called by thread manager while sleeping
(define dynamic-thread-yield#p
  (make-parameter #f))
