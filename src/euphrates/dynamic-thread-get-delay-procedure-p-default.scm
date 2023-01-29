
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-get-delay-procedure-p-default)
    :export (#{dynamic-thread-get-delay-procedure#p-default}#)
    :use-module ((euphrates dynamic-thread-sleep-p) :select (dynamic-thread-sleep#p))
    :use-module ((euphrates dynamic-thread-sleep) :select (dynamic-thread-sleep))
    :use-module ((euphrates dynamic-thread-get-wait-delay) :select (dynamic-thread-get-wait-delay)))))



(define (dynamic-thread-get-delay-procedure#p-default)
  (let ((timeout (dynamic-thread-get-wait-delay))
        (sleep (or (dynamic-thread-sleep#p) dynamic-thread-sleep)))
    (lambda _
      (sleep timeout))))
