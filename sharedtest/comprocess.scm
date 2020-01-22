
(let [[p (run-comprocess "echo" "hello" "from" "echo1")]] 0)

(let [[p (run-comprocess
          "/bin/echo" "hello" "from" "echo2")]] 0)

(let [[p (run-comprocess
          "/bin/sh" "-c" "echo hello from echo3")]] 0)

(let [[p (run-comprocess
          "/bin/sh" "-c" "echo hello from echo4 1>&2")]] 0)

(let [[p (run-comprocess
          "sl")]]
  (let lp []
    (usleep 10000)
    (unless (comprocess-exited? p)
      (lp))))

(let [[p (run-comprocess
          "/bin/sh"
          "-c"
          "sl")]]
  (let lp []
    (usleep (second-to-microsecond 1/2))
    (kill-comprocess-with-timeout p
                                  (second-to-microsecond 1/2))
    (unless (comprocess-exited? p)
      (usleep 100)
      (lp))))
