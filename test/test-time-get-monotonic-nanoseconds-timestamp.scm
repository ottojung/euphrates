

;; time-get-monotonic-nanoseconds-timestamp

(let ()
  (let ((ret (time-get-monotonic-nanoseconds-timestamp)))
    (assert (number? ret))
    (assert (integer? ret))
    (assert (> ret 0))))
