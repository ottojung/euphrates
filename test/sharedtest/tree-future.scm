
(define cb-count 0)

(define (cb1 . args)
  (printfln "cb 1: ~a" args))

(define mut (make-uni-spinlock-critical))

(define (child-cb-make n)
  (lambda args
    (with-critical
     mut
     (set! cb-count (1+ cb-count)))))

(define (child-make n)
  (lambda ()
    (printfln "child~a" n)
    (dynamic-thread-sleep (normal->micro@unit 3))))

(define (run-nth-child n)
  (tree-future-run
   (child-make n)
   (child-cb-make n)
   #f))

(define (fn1)

  (for-each
   (lambda (i)
     (run-nth-child i))
   (range 100))

  (printfln "fn 1"))

(define in-main-count 0)

(define (main)
  (set! in-main-count (1+ in-main-count))
  (printfln "in main ~a" in-main-count)

  (tree-future-run fn1
                   cb1
                   #f)
  (dynamic-thread-sleep (normal->micro@unit 10)))

(with-new-tree-future-env
 (with-np-thread-env#non-interruptible
  (main))

 (assertNorm (= cb-count 100))

 (with-np-thread-env#non-interruptible
  (main)))

(assertNorm (= cb-count 200))

(with-new-tree-future-env
 ;; not parameterized
 (main))

(assertNorm (= in-main-count 3))

;; there is no guarantee that callbacks will finish.. but its very likely
(usleep (normal->micro@unit 1/10))
(assertNorm (= cb-count 300))

