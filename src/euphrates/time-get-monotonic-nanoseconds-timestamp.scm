
%run guile

;; NOTE: this time is not parameterized because of performance penalty that would introduce.
;; Therefore, this timestamp should only be used for non-deterministic stuff, or the stuff that noone cares to test.
%var time-get-monotonic-nanoseconds-timestamp

%for (COMPILER "guile")

(use-modules (srfi srfi-19))

(define time-get-monotonic-nanoseconds-timestamp
  (let [[time-to-nanoseconds
         (lambda [time]
           (+ (time-nanosecond time)
              (* 1000000000 (time-second time))))]]
    (lambda []
      (time-to-nanoseconds
       ((@ (srfi srfi-19) current-time) time-monotonic)))))

%end
%for (COMPILER "racket")

(define [time-get-monotonic-nanoseconds-timestamp]
  (ceiling
   (* 1000000
      (current-inexact-milliseconds))))

%end
