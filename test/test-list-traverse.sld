
(define-library
  (test-list-traverse)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates list-traverse) list-traverse)
    (only (euphrates range) range)
    (only (scheme base)
          <
          begin
          if
          lambda
          let
          list
          quote
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-traverse.scm")))
    (else (include "test-list-traverse.scm"))))
