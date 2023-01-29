
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-get-delay-procedure)
    :export (dynamic-thread-get-delay-procedure)
    :use-module ((euphrates dynamic-thread-get-delay-procedure-p) :select (dynamic-thread-get-delay-procedure#p))
    :use-module ((euphrates dynamic-thread-get-delay-procedure-p-default) :select (dynamic-thread-get-delay-procedure#p-default)))))



(define (dynamic-thread-get-delay-procedure)
  (let ((p (dynamic-thread-get-delay-procedure#p)))
    (if p (p)
        (dynamic-thread-get-delay-procedure#p-default))))
