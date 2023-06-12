
(define-library
  (test-key-value-map)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates key-value-map)
          key-value-map/list)
    (only (scheme base)
          +
          begin
          let
          list
          quasiquote
          quote
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-key-value-map.scm")))
    (else (include "test-key-value-map.scm"))))
