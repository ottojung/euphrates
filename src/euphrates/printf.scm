
%run guile

%var printf

%for (COMPILER "guile")

%use (catch-any) "./catch-any.scm"
%use (conss) "./conss.scm"
%use (dynamic-thread-spawn#p) "./dynamic-thread-spawn-p.scm"
%use (raisu) "./raisu.scm"
%use (make-uni-spinlock-critical) "./uni-spinlock.scm"

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

%end
