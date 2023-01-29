
(cond-expand
 (guile
  (define-module (euphrates sys-mutex-unlock)
    :export (sys-mutex-unlock!))))


(cond-expand
 (guile

  (use-modules (srfi srfi-18))

  (define sys-mutex-unlock! mutex-unlock!)

  ))
