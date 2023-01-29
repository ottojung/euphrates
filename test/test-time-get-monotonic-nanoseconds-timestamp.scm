
(cond-expand
 (guile
  (define-module (test-time-get-monotonic-nanoseconds-timestamp)
    :use-module ((euphrates assert) :select (assert))
    :use-module ((euphrates time-get-monotonic-nanoseconds-timestamp) :select (time-get-monotonic-nanoseconds-timestamp)))))

;; time-get-monotonic-nanoseconds-timestamp

(let ()
  (let ((ret (time-get-monotonic-nanoseconds-timestamp)))
    (assert (number? ret))
    (assert (integer? ret))
    (assert (> ret 0))))
