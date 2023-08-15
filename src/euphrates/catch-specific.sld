
(define-library
  (euphrates catch-specific)
  (export catch-specific)
  (import
    (only (euphrates generic-error-huh)
          generic-error?))
  (import
    (only (euphrates generic-error-type-key)
          generic-error:type-key))
  (import
    (only (euphrates generic-error-value-unsafe)
          generic-error:value/unsafe))
  (import
    (only (scheme base)
          and
          begin
          define
          equal?
          guard
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path catch))
           (begin
             (include-from-path
               "euphrates/catch-specific.scm")))
    (else (include "catch-specific.scm"))))
