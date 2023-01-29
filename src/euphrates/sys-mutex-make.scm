
(cond-expand
 (guile
  (define-module (euphrates sys-mutex-make)
    :export (sys-mutex-make))))


(cond-expand
 (guile

  (use-modules (srfi srfi-18))

  (define sys-mutex-make (@ (srfi srfi-18) make-mutex))

  ))
