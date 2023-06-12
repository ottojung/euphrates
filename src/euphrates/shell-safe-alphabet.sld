
(define-library
  (euphrates shell-safe-alphabet)
  (export
    shell-safe/alphabet
    shell-safe/alphabet/index)
  (import
    (only (scheme base) begin case define else))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/shell-safe-alphabet.scm")))
    (else (include "shell-safe-alphabet.scm"))))
