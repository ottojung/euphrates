

;; np-thread

(define println
  (case-lambda
   ((msg)
    (display (string-append msg "\n")))
   ((msg n)
    (println (string-append msg " " (number->string n))))))

(define (test-body)
  (define [kek]
    (println "in kek"))

  (define cycles 4)

  (define lol-thread #f)

  (define [lol]
    (let loop ((n 0))
      (if (> n cycles)
          (println "lol ended")
          (begin
            (println "lol at" n)
            (dynamic-thread-yield)
            (println "lol after" n)
            (loop (+ 1 n))))))

  (define [zulul]
    (let loop ((n 0))
      (if (> n cycles)
          (println "zulul ended")
          (begin
            (println "zulul at" n)
            (when (= n 3)
              (dynamic-thread-cancel lol-thread))
            (dynamic-thread-yield)
            (println "zulul after" n)
            (loop (+ 1 n))))))

  (println "start")

  (dynamic-thread-yield)

  (dynamic-thread-spawn kek)
  (set! lol-thread (dynamic-thread-spawn lol))
  (dynamic-thread-spawn zulul)

  (println "end"))

(define parameterized-order
  (list
   "start"
   "end"
   "in kek"
   "lol at 0"
   "zulul at 0"
   "lol after 0"
   "lol at 1"
   "zulul after 0"
   "zulul at 1"
   "lol after 1"
   "lol at 2"
   "zulul after 1"
   "zulul at 2"
   "lol after 2"
   "lol at 3"
   "zulul after 2"
   "zulul at 3"
   "zulul after 3"
   "zulul at 4"
   "zulul after 4"
   "zulul ended"
   ""))

(assert=
 (lines->string parameterized-order)
 (with-output-stringified
   (with-np-thread-env/non-interruptible
    (test-body))))
