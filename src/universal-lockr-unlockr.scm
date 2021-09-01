
%run guile

%var universal-lockr!
%var universal-unlockr!

%use (hashmap) "./hashmap.scm"
%use (hashmap-ref hashmap-set!) "./ihashmap.scm"
%use (dynamic-thread-get-delay-procedure) "./dynamic-thread-get-delay-procedure.scm"
%use (with-critical) "./with-critical.scm"
%use (make-uni-spinlock-critical) "./uni-spinlock.scm"

;; Like uni-spinlock but use arbitary variables as lock target
;; and do sleep when wait
;; FIXME: this leaks memory
(define-values (universal-lockr! universal-unlockr!)
  (let ((critical (make-uni-spinlock-critical))
        (h (hashmap)))
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
        (hashmap-set! h resource #f))))))
