
(define-library
  (euphrates serialization-sexp-natural)
  (export
    serialize/sexp/natural
    deserialize/sexp/natural)
  (import
    (only (euphrates serialization-builtin-natural)
          deserialize-builtin/natural
          serialize-builtin/natural))
  (import
    (only (euphrates serialization-sexp-generic)
          deserialize/sexp/generic
          serialize/sexp/generic))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/serialization-sexp-natural.scm")))
    (else (include "serialization-sexp-natural.scm"))))
