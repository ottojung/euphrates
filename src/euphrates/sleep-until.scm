
(cond-expand
 (guile
  (define-module (euphrates sleep-until)
    :export (sleep-until)
    :use-module ((euphrates dynamic-thread-get-delay-procedure) :select (dynamic-thread-get-delay-procedure))
    :use-module ((euphrates dynamic-thread-yield) :select (dynamic-thread-yield))
    :use-module ((euphrates time-get-monotonic-nanoseconds-timestamp) :select (time-get-monotonic-nanoseconds-timestamp))
    :use-module ((euphrates unit-conversions) :select (milli->nano/unit)))))

;; Sleeps until condition evaluates to true or until timeout is reached.
;; Uses `dynamic-thread-get-delay-procedure' for sleeping.
;; Sleeps before the first check.
;;
;; @returns condition if it evaluated to a truthy value.
;; @returns #f if it timeouted.


(define-syntax sleep-until
  (syntax-rules ()
    ((_ condi)
     (let ((sleep (dynamic-thread-get-delay-procedure)))
       (dynamic-thread-yield)
       (or condi
           (let loop () (sleep) (or condi (loop))))))
    ((_ condi timeout-milliseconds)
     (let ((sleep (dynamic-thread-get-delay-procedure))
           (target-time (+ (milli->nano/unit timeout-milliseconds) (time-get-monotonic-nanoseconds-timestamp))))
       (dynamic-thread-yield)
       (or condi
           (let loop ()
             (sleep)
             (or condi
                 (and (> target-time (time-get-monotonic-nanoseconds-timestamp))
                      (loop)))))))))
