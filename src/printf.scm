
%run guile

%use (make-uni-spinlock-critical) "./uni-spinlock.scm"
%use (critical) "./critical.scm"
%use (catch-any) "./catch-any.scm"

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
              (apply format (cons* #t fmt args)))
            (lambda argv
              (set! err argv)))))
        (when err (apply throw err))))))

%end
