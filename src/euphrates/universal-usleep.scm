



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
