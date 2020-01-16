
(let [[p (run-comprocess "echo" "hello" "from" "echo")]] 0)

(let [[p (run-comprocess-with-output-to
          (current-output-port)
          "/bin/echo" "hello" "from" "echo")]] 0)

(let [[p (run-comprocess-with-output-to
          (current-output-port)
          "sl")]]
  (let lp []
    (usleep 10000)
    (unless (comprocess-exited? p)
      (lp))))

(let [[p (run-comprocess-with-output-to
          (current-output-port)
          "sl")]]
  (let lp []
    (usleep (second-to-microsecond 1/2))
    (kill-comprocess-with-timeout p
                                  (second-to-microsecond 1/2))
    (unless (comprocess-exited? p)
      (usleep 100)
      (lp))))
