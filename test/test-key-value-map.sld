
(define-library
  (test-key-value-map)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates key-value-map)
          key-value-map/list))
  (import
    (only (scheme base)
          +
          begin
          cond-expand
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
