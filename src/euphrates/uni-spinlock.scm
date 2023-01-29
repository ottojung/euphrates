
(cond-expand
 (guile
  (define-module (euphrates uni-spinlock)
    :export (make-uni-spinlock uni-spinlock-lock! uni-spinlock-unlock! make-uni-spinlock-critical)
    :use-module ((euphrates atomic-box) :select (make-atomic-box atomic-box-compare-and-set! atomic-box-set!))
    :use-module ((euphrates dynamic-thread-enable-cancel) :select (dynamic-thread-enable-cancel))
    :use-module ((euphrates dynamic-thread-disable-cancel) :select (dynamic-thread-disable-cancel))
    :use-module ((euphrates dynamic-thread-get-yield-procedure) :select (dynamic-thread-get-yield-procedure)))))



;; Universal spinlock
;; Works for any thread model
;; Very wasteful
(define-values
    (make-uni-spinlock
     uni-spinlock-lock!
     uni-spinlock-unlock!
     make-uni-spinlock-critical)

  (let* ((make (lambda () (make-atomic-box #f)))

         (lock
          (lambda (o)
            (let ((yield (dynamic-thread-get-yield-procedure)))
              (let lp ()
                (unless (atomic-box-compare-and-set!
                         o #f #t)
                  (yield)
                  (lp))))))

         (unlock
          (lambda (o)
            (atomic-box-set! o #f)))

         (critical
          (lambda ()
            (let ((box (make)))
              (lambda (thunk)
                (dynamic-thread-disable-cancel)
                (lock box)
                (let ((ret (thunk)))
                  (unlock box)
                  (dynamic-thread-enable-cancel)
                  ret))))))
    (values make lock unlock critical)))
