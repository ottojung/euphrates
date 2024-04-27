
(define-library
  (test-catch-many)
  (import (only (euphrates catch-many) catch-many))
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
           (begin (include-from-path "test-catch-many.scm")))
    (else (include "test-catch-many.scm"))))
