
%run guile

;; time-get-current-unixtime
%use (assert) "./src/assert.scm"
%use (time-get-current-unixtime) "./src/time-get-current-unixtime.scm"

(let ()
  (assert (number? (time-get-current-unixtime))))
