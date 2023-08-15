
(define-library
  (test-catch-specific)
  (import
    (only (euphrates catch-specific) catch-specific))
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
          lambda
          list
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-catch-specific.scm")))
    (else (include "test-catch-specific.scm"))))
