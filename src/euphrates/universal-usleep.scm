
(cond-expand
 (guile
  (define-module (euphrates universal-usleep)
    :export (universal-usleep)
    :use-module ((euphrates unit-conversions) :select (micro->nano/unit nano->micro/unit))
    :use-module ((euphrates time-get-monotonic-nanoseconds-timestamp) :select (time-get-monotonic-nanoseconds-timestamp))
    :use-module ((euphrates dynamic-thread-get-wait-delay) :select (dynamic-thread-get-wait-delay))
    :use-module ((euphrates dynamic-thread-get-yield-procedure) :select (dynamic-thread-get-yield-procedure))
    :use-module ((euphrates sys-usleep) :select (sys-usleep)))))



(define (universal-usleep micro-seconds)
  (let* ((nano-seconds (micro->nano/unit micro-seconds))
         (start-time (time-get-monotonic-nanoseconds-timestamp))
         (end-time (+ start-time nano-seconds))
         (sleep-rate (dynamic-thread-get-wait-delay))
         (yield (dynamic-thread-get-yield-procedure)))
    (let lp ()
      (yield)
      (let ((t (time-get-monotonic-nanoseconds-timestamp)))
        (unless (> t end-time)
          (let ((s (min sleep-rate (nano->micro/unit (- end-time t)))))
            (sys-usleep s)
            (lp)))))))
