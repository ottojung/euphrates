
%run guile

%use (make-atomic-box atomic-box-compare-and-set! atomic-box-set!) "./atomic-box.scm"
%use (dynamic-thread-enable-cancel) "./dynamic-thread-enable-cancel.scm"
%use (dynamic-thread-disable-cancel) "./dynamic-thread-disable-cancel.scm"
%use (dynamic-thread-get-yield-procedure) "./dynamic-thread-get-yield-procedure.scm"

%var make-uni-spinlock
%var uni-spinlock-lock!
%var uni-spinlock-unlock!
%var make-uni-spinlock-critical

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
