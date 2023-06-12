
(define-library
  (euphrates shell-nondisrupt-alphabet)
  (export
    shell-nondisrupt/alphabet
    shell-nondisrupt/alphabet/index)
  (import
    (only (scheme base) begin case define else))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/shell-nondisrupt-alphabet.scm")))
    (else (include "shell-nondisrupt-alphabet.scm"))))
