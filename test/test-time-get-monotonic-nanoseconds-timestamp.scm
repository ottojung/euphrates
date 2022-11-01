
%run guile

;; time-get-monotonic-nanoseconds-timestamp
%use (assert) "./src/assert.scm"
%use (time-get-monotonic-nanoseconds-timestamp) "./src/time-get-monotonic-nanoseconds-timestamp.scm"

(let ()
  (let ((ret (time-get-monotonic-nanoseconds-timestamp)))
    (assert (number? ret))
    (assert (integer? ret))
    (assert (> ret 0))))
