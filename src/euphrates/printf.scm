
(cond-expand
 (guile
  (define-module (euphrates printf)
    :export (printf)
    :use-module ((euphrates catch-any) :select (catch-any))
    :use-module ((euphrates conss) :select (conss))
    :use-module ((euphrates dynamic-thread-spawn-p) :select (dynamic-thread-spawn#p))
    :use-module ((euphrates raisu) :select (raisu))
    :use-module ((euphrates uni-spinlock) :select (make-uni-spinlock-critical)))))


(cond-expand
 (guile


  (use-modules (ice-9 format))

  ;; depends on uni-spinlock
  (define printf/threadsafe
    (let [[critical (make-uni-spinlock-critical)]]
      (lambda [fmt args]
    (let [[err #f]]
          (critical
           (lambda []
             (catch-any
              (lambda []
        (apply format (conss #t fmt args)))
              (lambda argv
        (set! err argv)))))
          (when err (apply raisu err))))))

  (define (printf fmt . args)
    (if (dynamic-thread-spawn#p)
    (printf/threadsafe fmt args)
    (apply format (conss #t fmt args))))

  ))
