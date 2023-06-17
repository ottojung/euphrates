

;; Kills the current thread when it calls yield,
;; so does not kill threads right away.


(define (dynamic-thread-cancel th)
  ((or (dynamic-thread-cancel/p)
       (raisu 'threading-system-is-not-parameterized)) th))
