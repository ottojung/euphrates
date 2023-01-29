
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-get-wait-delay)
    :export (dynamic-thread-get-wait-delay)
    :use-module ((euphrates dynamic-thread-wait-delay-p-default) :select (dynamic-thread-wait-delay#us#p-default))
    :use-module ((euphrates dynamic-thread-wait-delay-p) :select (dynamic-thread-wait-delay#us#p)))))



(define (dynamic-thread-get-wait-delay)
  (or (dynamic-thread-wait-delay#us#p)
      dynamic-thread-wait-delay#us#p-default))
