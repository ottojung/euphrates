

(cond-expand
 (guile
  (define sys-usleep usleep))
 (racket
  (define (sys-usleep microsecond)
    (sleep (/ microsecond 1000000)))))
