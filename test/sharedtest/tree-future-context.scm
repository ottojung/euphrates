
(define (cb1 . args)
  (printfln "cb1: ~a" args))

(define (fn1)
  (define last -1)
  (let lp ()
    (printfln "HELLO THERE")
    (define cur (tree-future-eval-context))
    (unless (= cur last)
      (set! last cur)
      (printfln "new cur: ~a" cur))
    (dynamic-thread-sleep (normal->micro@unit 1/100))
    (when (> last 100)
      (printfln "BIGGER"))
    (unless (> last 100)
      (lp))))

(define (main)

  (define time time-get-monotonic-nanoseconds-timestamp)
  (define curtime (time))
  (define endtime (+ curtime (normal->nano@unit 5)))

  (define child (tree-future-run fn1 #f cb1 0))

  (let lp ()
    (when (< (time) endtime)
      (tree-future-modify child 1+)
      (dynamic-thread-sleep (normal->micro@unit 1/100))
      (lp))))

(with-new-tree-future-env
 ;; not parameterized
 (main))

(printfln "end of test")

