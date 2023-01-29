
%run guile

%use (assert=) "./euphrates/assert-equal.scm"
%use (date-get-current-time24h-string) "./euphrates/date-get-current-time24h-string.scm"
%use (time-get-current-unixtime/values#p) "./euphrates/time-get-current-unixtime-values-p.scm"

(let () ;; date-get-current-time24h-string
  (parameterize ((time-get-current-unixtime/values#p (lambda () (values 567 1234))))
    (assert= "01:09:27"
             (date-get-current-time24h-string))))
