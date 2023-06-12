
(define-library
  (euphrates petri-error-handling)
  (export
    patri-handle-make-callback
    petri-handle-get)
  (import
    (only (scheme base)
          and
          assoc
          begin
          cadr
          define
          lambda
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/petri-error-handling.scm")))
    (else (include "petri-error-handling.scm"))))
