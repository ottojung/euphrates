
(cond-expand
 (guile
  (define-module (test-time-get-current-unixtime)
    :use-module ((euphrates assert) :select (assert))
    :use-module ((euphrates time-get-current-unixtime) :select (time-get-current-unixtime)))))

;; time-get-current-unixtime

(let ()
  (assert (number? (time-get-current-unixtime))))
