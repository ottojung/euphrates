
(cond-expand
 (guile
  (define-module (euphrates sys-mutex-lock)
    :export (sys-mutex-lock!))))


(cond-expand
 (guile

  (use-modules (srfi srfi-18))

  (define sys-mutex-lock! mutex-lock!)

  ))
