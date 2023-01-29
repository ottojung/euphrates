

(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-mutex-make)
    :export (dynamic-thread-mutex-make)
    :use-module ((euphrates dynamic-thread-mutex-make-p) :select (dynamic-thread-mutex-make#p))
    :use-module ((euphrates dynamic-thread-mutex-make-p-default) :select (dynamic-thread-mutex-make#p-default)))))



(define (dynamic-thread-mutex-make)
  ((or (dynamic-thread-mutex-make#p)
       dynamic-thread-mutex-make#p-default)))
