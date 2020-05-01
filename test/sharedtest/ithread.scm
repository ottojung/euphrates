
;; (define cur (current-thread))
;; (i-thread-yield cur)

(with-np-thread-env#non-interruptible
 (with-i-thread-env#interruptible
  (printfln "preemptive test")

  (define [kek]
    (printfln "in kek"))

  (define cycles 20)

  (define [lol]
    (apploop [n] [0]
             (if (> n cycles)
                 (printfln "lol ended")
                 (begin
                   (printfln "lol at ~a" n)
                   (usleep 100000)
                   (loop (1+ n))))))

  (define [zulul]
    (apploop [n] [0]
             (if (> n cycles)
                 (printfln "zulul ended")
                 (begin
                   (printfln "zulul at ~a" n)
                   (usleep 100000)
                   (loop (1+ n))))))

  (dynamic-thread-spawn kek)
  (dynamic-thread-spawn lol)
  (dynamic-thread-spawn zulul)

  (printfln "end")))

(with-np-thread-env#non-interruptible
 (with-i-thread-env#interruptible

  (printfln "critical test")

  (define [kek]
    (printfln "in kek"))

  (define cycles 20)

  (define [lol]
    (i-thread-critical!
     (apploop [n] [0]
              (if (> n cycles)
                  (printfln "lol ended")
                  (begin
                    (printfln "lol at ~a" n)
                    (usleep 100000)
                    (loop (1+ n)))))))

  (define [zulul]
    (i-thread-critical!
     (apploop [n] [0]
              (if (> n cycles)
                  (printfln "zulul ended")
                  (begin
                    (printfln "zulul at ~a" n)
                    (usleep 100000)
                    (loop (1+ n)))))))

  (dynamic-thread-spawn kek)
  (dynamic-thread-spawn lol)
  (dynamic-thread-spawn zulul)

  (printfln "end")))
