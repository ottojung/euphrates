
(define-library
  (euphrates log-monad)
  (export log-monad)
  (import
    (only (euphrates dprint) dprint)
    (only (euphrates monad-make-no-cont)
          monad-make/no-cont)
    (only (euphrates monadfinobj) monadfinobj?)
    (only (euphrates monadstate)
          monadstate-args
          monadstate-qval
          monadstate-qvar)
    (only (euphrates tilda-a) ~a)
    (only (euphrates words-to-string) words->string)
    (only (scheme base) begin define if lambda map))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/log-monad.scm")))
    (else (include "log-monad.scm"))))
