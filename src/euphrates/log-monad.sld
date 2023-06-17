
(define-library
  (euphrates log-monad)
  (export log-monad)
  (import (only (euphrates dprint) dprint))
  (import
    (only (euphrates monad-make-no-cont)
          monad-make/no-cont))
  (import
    (only (euphrates monadfinobj) monadfinobj?))
  (import
    (only (euphrates monadstate)
          monadstate-args
          monadstate-qval
          monadstate-qvar))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (euphrates words-to-string) words->string))
  (import
    (only (scheme base) begin define if lambda map))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/log-monad.scm")))
    (else (include "log-monad.scm"))))
