
%run guile

%use (assert=) "./euphrates/assert-equal.scm"
%use (date-get-current-string) "./euphrates/date-get-current-string.scm"
%use (time-get-current-unixtime/values#p) "./euphrates/time-get-current-unixtime-values-p.scm"

(let () ;; date-get-current-string
  (parameterize ((time-get-current-unixtime/values#p (lambda () (values 567 1234))))
    (assert= "1970/01/01 01:09:27"
             (date-get-current-string "~Y/~m/~d ~H:~M:~S"))))
