
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-cancel)
    :export (dynamic-thread-cancel)
    :use-module ((euphrates dynamic-thread-cancel-p) :select (dynamic-thread-cancel#p))
    :use-module ((euphrates raisu) :select (raisu)))))

;; Kills the current thread when it calls yield,
;; so does not kill threads right away.


(define (dynamic-thread-cancel th)
  ((or (dynamic-thread-cancel#p)
       (raisu 'threading-system-is-not-parameterized)) th))
