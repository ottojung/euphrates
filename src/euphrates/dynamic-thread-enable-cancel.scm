
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-enable-cancel)
    :export (dynamic-thread-enable-cancel)
    :use-module ((euphrates dynamic-thread-enable-cancel-p) :select (dynamic-thread-enable-cancel#p))
    :use-module ((euphrates dynamic-thread-enable-cancel-p-default) :select (dynamic-thread-enable-cancel#p-default)))))


(define (dynamic-thread-enable-cancel)
  ((or (dynamic-thread-enable-cancel#p)
       dynamic-thread-enable-cancel#p-default)))


