
;; depends on uni-spinlock
(define printf/threadsafe
  (let ((critical (make-uni-spinlock-critical)))
    (lambda (fmt args)
      (let ((err #f))
        (critical
         (lambda ()
           (catch-any
            (lambda _
              (display (apply stringf (cons fmt args))))
            (lambda argv
              (set! err argv)))))
        (when err (apply raisu err))))))
