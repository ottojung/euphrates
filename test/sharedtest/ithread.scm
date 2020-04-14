
;; (define cur (current-thread))
;; (i-thread-yield cur)

(i-thread-run!
 (println "preemptive test")

 (define [kek]
   (println "in kek"))

 (define cycles 20)

 (define [lol]
   (apploop [n] [0]
            (if (> n cycles)
                (println "lol ended")
                (begin
                  (println "lol at ~a" n)
                  (usleep 100000)
                  (loop (1+ n))))))

 (define [zulul]
   (apploop [n] [0]
            (if (> n cycles)
                (println "zulul ended")
                (begin
                  (println "zulul at ~a" n)
                  (usleep 100000)
                  (loop (1+ n))))))

 (np-thread-fork kek)
 (np-thread-fork lol)
 (np-thread-fork zulul)

 (println "end"))

(i-thread-run!
 (println "critical test")

 (define [kek]
   (println "in kek"))

 (define cycles 20)

 (define [lol]
   (i-thread-critical!
    (apploop [n] [0]
             (if (> n cycles)
                 (println "lol ended")
                 (begin
                   (println "lol at ~a" n)
                   (usleep 100000)
                   (loop (1+ n)))))))

 (define [zulul]
   (i-thread-critical!
    (apploop [n] [0]
             (if (> n cycles)
                 (println "zulul ended")
                 (begin
                   (println "zulul at ~a" n)
                   (usleep 100000)
                   (loop (1+ n)))))))

 (np-thread-fork kek)
 (np-thread-fork lol)
 (np-thread-fork zulul)

 (println "end"))
