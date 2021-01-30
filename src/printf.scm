
%run guile

%use (make-uni-spinlock-critical) "./uni-spinlock.scm"
%use (catch-any) "./catch-any.scm"
%use (conss) "./conss.scm"
%use (raisu) "./raisu.scm"

%for (COMPILER "guile")

(use-modules (ice-9 format))

%var printf

;; depends on uni-spinlock
(define printf
  (let [[critical (make-uni-spinlock-critical)]]
    (lambda [fmt . args]
      (let [[err #f]]
        (critical
         (lambda []
           (catch-any
            (lambda []
              (apply format (conss #t fmt args)))
            (lambda argv
              (set! err argv)))))
        (when err (apply raisu err))))))

%end
