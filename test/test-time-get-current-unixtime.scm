
%run guile

;; time-get-current-unixtime
%use (assert) "./euphrates/assert.scm"
%use (time-get-current-unixtime) "./euphrates/time-get-current-unixtime.scm"

(let ()
  (assert (number? (time-get-current-unixtime))))
