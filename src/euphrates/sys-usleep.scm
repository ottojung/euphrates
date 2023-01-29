
(cond-expand
 (guile
  (define-module (euphrates sys-usleep)
    :export (sys-usleep))))


(cond-expand
 (guile

  (define sys-usleep usleep)

  ))
(cond-expand
 (racket

  (define (sys-usleep microsecond)
    (sleep (/ microsecond 1000000)))

  ))
