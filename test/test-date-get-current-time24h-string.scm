
(cond-expand
  (guile)
  ((not guile)
   (import (only (scheme base) begin cond-expand))))



;; NOTE: guile timezones are broken

;; (let () ;; date-get-current-time24h-string
;;   (parameterize ((time-get-current-unixtime/values/p (lambda () (values 567 1234))))
;;     (assert= "01:09:27"
;;              (date-get-current-time24h-string))))
