
(cond-expand
 (guile
  (define-module (test-date-get-current-string)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates date-get-current-string) :select (date-get-current-string))
    :use-module ((euphrates time-get-current-unixtime-values-p) :select (time-get-current-unixtime/values#p)))))


;; NOTE: guile timezones are broken

;; (let () ;; date-get-current-string
;;   (parameterize ((time-get-current-unixtime/values#p (lambda () (values 567 1234))))
;;     (assert= "1970/01/01 01:09:27"
;;              (date-get-current-string "~Y/~m/~d ~H:~M:~S"))))
