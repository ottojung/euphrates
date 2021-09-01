
%run guile

%var universal-usleep

%use (micro->nano/unit nano->micro/unit) "./unit-conversions.scm"
%use (time-get-monotonic-nanoseconds-timestamp) "./time-get-monotonic-nanoseconds-timestamp.scm"
%use (dynamic-thread-get-wait-delay) "./dynamic-thread-get-wait-delay.scm"
%use (dynamic-thread-get-yield-procedure) "./dynamic-thread-get-yield-procedure.scm"
%use (sys-usleep) "./sys-usleep.scm"

(define (universal-usleep micro-seconds)
  (let* ((nano-seconds (micro->nano/unit micro-seconds))
         (start-time (time-get-monotonic-nanoseconds-timestamp))
         (end-time (+ start-time nano-seconds))
         (sleep-rate (dynamic-thread-wait-delay))
         (yield (dynamic-thread-get-yield-procedure)))
    (let lp ()
      (yield)
      (let ((t (time-get-monotonic-nanoseconds-timestamp)))
        (unless (> t end-time)
          (let ((s (min sleep-rate (nano->micro/unit (- end-time t)))))
            (sys-usleep s)
            (lp)))))))
