
(define-library
  (euphrates replacement-monad)
  (export replacement-monad)
  (import
    (only (euphrates monad-make-no-cont)
          monad-make/no-cont))
  (import
    (only (euphrates monadstate)
          monadstate-lval
          monadstate-qtags
          monadstate-ret/thunk))
  (import
    (only (scheme base) begin define lambda let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/replacement-monad.scm")))
    (else (include "replacement-monad.scm"))))
