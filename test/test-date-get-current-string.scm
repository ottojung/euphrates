
%run guile

%use (assert=) "./src/assert-equal.scm"
%use (date-get-current-string) "./src/date-get-current-string.scm"
%use (time-get-current-unixtime/values#p) "./src/time-get-current-unixtime-values-p.scm"

(let () ;; date-get-current-string
  (parameterize ((time-get-current-unixtime/values#p (lambda () (values 567 1234))))
    (assert= "1970/01/01 01:09:27"
             (date-get-current-string "~Y/~m/~d ~H:~M:~S"))))
