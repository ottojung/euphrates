
;; (define cur (current-thread))
;; (i-thread-yield cur)

(with-np-thread-env#non-interruptible
 (with-i-thread-env#interruptible
  (dprintln "preemptive test")

  (define [kek]
    (dprintln "in kek"))

  (define cycles 20)

  (define [lol]
    (apploop [n] [0]
             (if (> n cycles)
                 (dprintln "lol ended")
                 (begin
                   (dprintln "lol at ~a" n)
                   (usleep 100000)
                   (loop (1+ n))))))

  (define [zulul]
    (apploop [n] [0]
             (if (> n cycles)
                 (dprintln "zulul ended")
                 (begin
                   (dprintln "zulul at ~a" n)
                   (usleep 100000)
                   (loop (1+ n))))))

  (dynamic-thread-spawn kek)
  (dynamic-thread-spawn lol)
  (dynamic-thread-spawn zulul)

  (dprintln "end")))

(with-np-thread-env#non-interruptible
 (with-i-thread-env#interruptible

  (dprintln "critical test")

  (define [kek]
    (dprintln "in kek"))

  (define cycles 20)

  (define [lol]
    (i-thread-critical!
     (apploop [n] [0]
              (if (> n cycles)
                  (dprintln "lol ended")
                  (begin
                    (dprintln "lol at ~a" n)
                    (usleep 100000)
                    (loop (1+ n)))))))

  (define [zulul]
    (i-thread-critical!
     (apploop [n] [0]
              (if (> n cycles)
                  (dprintln "zulul ended")
                  (begin
                    (dprintln "zulul at ~a" n)
                    (usleep 100000)
                    (loop (1+ n)))))))

  (dynamic-thread-spawn kek)
  (dynamic-thread-spawn lol)
  (dynamic-thread-spawn zulul)

  (dprintln "end")))
