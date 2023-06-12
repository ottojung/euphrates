
(define-library
  (euphrates command-line-arguments-p)
  (export command-line-argumets/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/command-line-arguments-p.scm")))
    (else (include "command-line-arguments-p.scm"))))
