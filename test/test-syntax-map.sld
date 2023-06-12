
(define-library
  (test-syntax-map)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates syntax-map) syntax-map)
    (only (scheme base)
          _
          begin
          cons
          define-syntax
          let
          list
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-syntax-map.scm")))
    (else (include "test-syntax-map.scm"))))
