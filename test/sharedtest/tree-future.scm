
(define CHILD-COUNT 100)

(define body-count 0)

(define failed #t)

(define mut (make-uni-spinlock-critical))

(define (main-cb structure status . args)
  (set! failed #t)

  (with-critical
   mut
   (assert-equal body-count CHILD-COUNT)
   (set! body-count 0))

  (set! failed #f)

  (dprintln "main cb: ~a ~a" status args))

(define (child-cb-make n)
  (lambda (structure status . args)
    ;; (dprintln "child~a-cb: ~a ~a" n status args)
    (set! failed #t)
    (assert-equal status 'ok)
    (set! failed #f)
    (with-critical
     mut
     (set! body-count (1+ body-count)))
    ))

(define (child-make n)
  (lambda ()
    ;; (dynamic-thread-sleep (normal->micro@unit 3))

    (define t1 (tree-future-run-task 2))
    (define t2 (tree-future-run-task 3))
    (define re (tree-future-wait-task t1 t2))
    (define s (apply + re))
    (assert-equal s 5)
    ;; (dprintln "child ~a" n)
    ))

(define (run-nth-child n)
  (tree-future-run
   (child-make n)
   #f
   (child-cb-make n)
   #f))

(define (main-body)

  (for-each
   (lambda (i)
     (run-nth-child i))
   (range CHILD-COUNT))

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
(assert-equal in-main-count 3)

