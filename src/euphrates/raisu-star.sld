
(define-library
  (euphrates raisu-star)
  (export raisu*)
  (import
    (only (euphrates generic-error-irritants-key)
          generic-error:irritants-key))
  (import
    (only (euphrates generic-error-message-key)
          generic-error:message-key))
  (import
    (only (euphrates generic-error-type-key)
          generic-error:type-key))
  (import
    (only (euphrates generic-error) generic-error))
  (import
    (only (scheme base)
          _
          begin
          cons
          define-syntax
          list
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/raisu-star.scm")))
    (else (include "raisu-star.scm"))))
