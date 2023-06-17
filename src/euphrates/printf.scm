
;; depends on uni-spinlock
(define printf/threadsafe
  (let [[critical (make-uni-spinlock-critical)]]
    (lambda [fmt args]
      (let [[err #f]]
        (critical
         (lambda []
           (catch-any
            (lambda []
              (display (apply stringf (cons fmt args))))
            (lambda argv
              (set! err argv)))))
        (when err (apply raisu err))))))

(define (printf fmt . args)
  (if (dynamic-thread-spawn/p)
      (printf/threadsafe fmt args)
      (display (apply stringf (cons fmt args)))))
