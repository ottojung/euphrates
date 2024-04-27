
(define-library
  (euphrates catch-many)
  (export catch-many)
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
          guard
          let
          member))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/catch-many.scm")))
    (else (include "catch-many.scm"))))
