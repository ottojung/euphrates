
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-disable-cancel)
    :export (dynamic-thread-disable-cancel)
    :use-module ((euphrates dynamic-thread-disable-cancel-p) :select (dynamic-thread-disable-cancel#p))
    :use-module ((euphrates dynamic-thread-disable-cancel-p-default) :select (dynamic-thread-disable-cancel#p-default)))))



(define (dynamic-thread-disable-cancel)
  ((or (dynamic-thread-disable-cancel#p)
       dynamic-thread-disable-cancel#p-default)))


