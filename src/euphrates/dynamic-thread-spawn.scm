
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-spawn)
    :export (dynamic-thread-spawn)
    :use-module ((euphrates dynamic-thread-spawn-p) :select (dynamic-thread-spawn#p))
    :use-module ((euphrates raisu) :select (raisu)))))



(define (dynamic-thread-spawn thunk)
  ((or (dynamic-thread-spawn#p)
       (raisu 'threading-system-is-not-parameterized)) thunk))
