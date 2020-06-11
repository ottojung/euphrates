
(define CHILD-COUNT 99)

(define cb-count 0)

(define failed #t)
(define missed-cancel #f)

(define mut (make-uni-spinlock-critical))

(define (main-cb structure status . args)
  (set! failed #t)

  (with-critical
   mut
   (assert-equal cb-count CHILD-COUNT)
   (set! cb-count 0))

  (set! failed #f)

  (dprintln "main cb: ~a ~a" status args))

(define (child-cb-make n)
  (lambda (structure status . args)
    (assert-equal status 'cancel)
    (with-critical
     mut
     (set! cb-count (1+ cb-count)))
    ))

(define (child-make n)
  (lambda ()
    (dynamic-thread-sleep (normal->micro@unit 4))

    (set! missed-cancel #t)

    (dprintln "HERE!")
    ))

(define (run-nth-child n)
  (tree-future-run
   (child-make n)
   #f
   (child-cb-make n)
   #f))

(define (cancel-nth-child child)
  (tree-future-cancel child 'down))

(define (main-body)

  (define children
    (map
     (lambda (i)
       (run-nth-child i))
     (range CHILD-COUNT)))

  (dynamic-thread-sleep (normal->micro@unit 1))

  (for-each
   (lambda (child)
     (cancel-nth-child child))
   children)

  (dprintln "main body"))

(define in-main-count 0)

(define (main)
  (set! in-main-count (1+ in-main-count))
  (dprintln "in main ~a" in-main-count)

  (tree-future-run main-body
                   #f
                   main-cb
                   #f))

(with-new-tree-future-env
 (with-np-thread-env#non-interruptible
  (main))

 (with-np-thread-env#non-interruptible
  (main)))

(with-new-tree-future-env
 ;; not parameterized
 (main))

(assert (not failed))
(assert (not missed-cancel))
(assert-equal in-main-count 3)

