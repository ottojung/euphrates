
(define-library
  (euphrates maybe-monad)
  (export maybe-monad)
  (import
    (only (euphrates identity-star) identity*))
  (import (only (euphrates monad-make) monad-make))
  (import
    (only (euphrates monadstate)
          monadstate-args
          monadstate-cret
          monadstate-ret))
  (import
    (only (scheme base) apply begin define if lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/maybe-monad.scm")))
    (else (include "maybe-monad.scm"))))
