
(define-library
  (euphrates alphanum-alphabet)
  (export
    alphanum/alphabet
    alphanum/alphabet/index)
  (import
    (only (scheme base) begin case define else))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/alphanum-alphabet.scm")))
    (else (include "alphanum-alphabet.scm"))))
