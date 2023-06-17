
(define-library
  (euphrates eval-in-current-namespace)
  (export eval-in-current-namespace)
  (import
    (only (scheme base) begin cond-expand define))
  (import (only (scheme eval) eval))
  (import
    (only (scheme repl) interaction-environment))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/eval-in-current-namespace.scm")))
    (else (include "eval-in-current-namespace.scm"))))
