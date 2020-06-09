
(let [[p (run-comprocess "echo" "hello" "from" "echo1")]] 0)

(let [[p (run-comprocess
          "/bin/echo" "hello" "from" "echo2")]] 0)

(let [[p (run-comprocess
          "/bin/sh" "-c" "echo hello from echo3")]] 0)

(let [[p (run-comprocess
          "/bin/sh" "-c" "echo hello from echo4 1>&2")]] 0)

(let [[p (run-comprocess
          "/bin/sh" "-c" "sleep 5 && echo hello from echo5 1>&2")]]
  (sleep-until (comprocess-exited? p)))

(printfln "ALL EXITED")

;; (let [[p (run-comprocess
;;           "sl")]]
;;   (let lp []
;;     (usleep 10000)
;;     (unless (comprocess-exited? p)
;;       (lp))))

;; (let [[p (run-comprocess
;;           "/bin/sh"
;;           "-c"
;;           "sl")]]
;;   (let lp []
;;     (usleep (normal->micro@unit 1/2))
;;     (kill-comprocess-with-timeout p
;;                                   (normal->micro@unit 1/2))
;;     (unless (comprocess-exited? p)
;;       (usleep 100)
;;       (lp))))

