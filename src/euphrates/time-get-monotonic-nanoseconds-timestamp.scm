

;; NOTE: this time is not parameterized because of performance penalty that would introduce.
;; Therefore, this timestamp should only be used for non-deterministic stuff, or the stuff that noone cares to test.

(cond-expand
 (guile

  (define time-get-monotonic-nanoseconds-timestamp
    (let [[time-to-nanoseconds
           (lambda [time]
             (+ (time-nanosecond time)
                (* 1000000000 (time-second time))))]]
      (lambda _
        (time-to-nanoseconds
         (current-time time-monotonic)))))

  )

 (racket

  (define [time-get-monotonic-nanoseconds-timestamp]
    (ceiling
     (* 1000000
    (current-inexact-milliseconds))))

  ))
