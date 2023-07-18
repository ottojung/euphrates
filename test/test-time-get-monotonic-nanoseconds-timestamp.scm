
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert) assert))
   (import
     (only (euphrates
             time-get-monotonic-nanoseconds-timestamp)
           time-get-monotonic-nanoseconds-timestamp))
   (import
     (only (scheme base)
           >
           begin
           cond-expand
           integer?
           let
           number?))))


;; time-get-monotonic-nanoseconds-timestamp

(let ()
  (let ((ret (time-get-monotonic-nanoseconds-timestamp)))
    (assert (number? ret))
    (assert (integer? ret))
    (assert (> ret 0))))
