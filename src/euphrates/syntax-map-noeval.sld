
(define-library
  (euphrates syntax-map-noeval)
  (export syntax-map/noeval)
  (import
    (only (euphrates syntax-reverse) syntax-reverse))
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/syntax-map-noeval.scm")))
    (else (include "syntax-map-noeval.scm"))))
