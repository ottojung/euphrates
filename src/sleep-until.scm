
%run guile

;; Sleeps until condition evaluates to true or until timeout is reached.
;; Uses `dynamic-thread-get-delay-procedure' for sleeping.
;; Sleeps before the first check.
;;
;; @returns #f if condition evaluated to true.
;; @returns #t if timeouted.
%var sleep-until

%use (dynamic-thread-get-delay-procedure) "./dynamic-thread-get-delay-procedure.scm"
%use (time-get-monotonic-nanoseconds-timestamp) "./time-get-monotonic-nanoseconds-timestamp.scm"
%use (milli->nano/unit) "./unit-conversions.scm"

(define-syntax sleep-until
  (syntax-rules ()
    ((_ condi)
     (let ((sleep (dynamic-thread-get-delay-procedure)))
       (let loop () (sleep) (unless condi (loop)))
       #f))
    ((_ condi timeout-milliseconds)
     (let ((sleep (dynamic-thread-get-delay-procedure))
           (target-time (+ (milli->nano/unit timeout-milliseconds) (time-get-monotonic-nanoseconds-timestamp))))
       (let loop ()
         (sleep)
         (if condi #f
             (if (> (time-get-monotonic-nanoseconds-timestamp) target-time)
                 #t
                 (loop))))))))


