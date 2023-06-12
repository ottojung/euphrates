
(define-library
  (euphrates uri-safe-alphabet)
  (export
    uri-safe/alphabet
    uri-safe/alphabet/index)
  (import
    (only (scheme base) begin case define else))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/uri-safe-alphabet.scm")))
    (else (include "uri-safe-alphabet.scm"))))
