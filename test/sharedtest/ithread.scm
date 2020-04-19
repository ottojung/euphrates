
;; (define cur (current-thread))
;; (i-thread-yield cur)

(i-thread-run!
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

 (np-thread-fork kek)
 (np-thread-fork lol)
 (np-thread-fork zulul)

 (printfln "end"))

(i-thread-run!
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

 (np-thread-fork kek)
 (np-thread-fork lol)
 (np-thread-fork zulul)

 (printfln "end"))
