
(define-library
  (euphrates raisu-star)
  (export raisu*)
  (import
    (only (euphrates generic-error-from-key)
          generic-error:from-key))
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
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          _
          append
          begin
          cons
          define-syntax
          if
          list
          quote
          string->symbol
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/raisu-star.scm")))
    (else (include "raisu-star.scm"))))
