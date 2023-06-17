
(define-library
  (euphrates serialization-sexp-short)
  (export
    serialize/sexp/short
    deserialize/sexp/short)
  (import
    (only (euphrates serialization-builtin-short)
          deserialize-builtin/short
          serialize-builtin/short))
  (import
    (only (euphrates serialization-sexp-generic)
          deserialize/sexp/generic
          serialize/sexp/generic))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/serialization-sexp-short.scm")))
    (else (include "serialization-sexp-short.scm"))))
