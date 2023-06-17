
(define-library
  (euphrates identity-monad)
  (export identity-monad)
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates monad-make-no-cont-no-fin)
          monad-make/no-cont/no-fin))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/identity-monad.scm")))
    (else (include "identity-monad.scm"))))
