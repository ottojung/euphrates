



;; Like uni-spinlock but use arbitary variables as lock target
;; and do sleep when wait
(define-values (universal-lockr! universal-unlockr!)
  (let ((critical (make-uni-spinlock-critical))
        (h (make-hashmap)))
    (values
     (lambda (resource)
       (let ((sleep (dynamic-thread-get-delay-procedure)))
         (let lp ()
           (when
               (with-critical
                critical
                (let ((r (hashmap-ref h resource #f)))
                  (if r
                      #t
                      (begin
                        (hashmap-set! h resource #t)
                        #f))))
             (sleep)
             (lp)))))
     (lambda (resource)
       (with-critical
        critical
        (hashmap-delete! h resource))))))
