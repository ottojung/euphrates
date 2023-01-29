
(cond-expand
 (guile
  (define-module (test-date-get-current-time24h-string)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates date-get-current-time24h-string) :select (date-get-current-time24h-string))
    :use-module ((euphrates time-get-current-unixtime-values-p) :select (time-get-current-unixtime/values#p)))))


(let () ;; date-get-current-time24h-string
  (parameterize ((time-get-current-unixtime/values#p (lambda () (values 567 1234))))
    (assert= "01:09:27"
             (date-get-current-time24h-string))))
