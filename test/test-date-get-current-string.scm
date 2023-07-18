
(cond-expand
  (guile)
  ((not guile)
   (import (only (scheme base) begin cond-expand))))



;; NOTE: guile timezones are broken

;; (let () ;; date-get-current-string
;;   (parameterize ((time-get-current-unixtime/values/p (lambda () (values 567 1234))))
;;     (assert= "1970/01/01 01:09:27"
;;              (date-get-current-string "~Y/~m/~d ~H:~M:~S"))))
