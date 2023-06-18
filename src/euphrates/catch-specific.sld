
(define-library
  (euphrates catch-specific)
  (export catch-specific)
  (import
    (only (scheme base)
          and
          apply
          begin
          car
          cond-expand
          define
          else
          equal?
          guard
          pair?))
  (cond-expand
    (guile (import (only (guile) include-from-path catch))
           (begin
             (include-from-path
               "euphrates/catch-specific.scm")))
    (else (include "catch-specific.scm"))))
