
(define-library
  (test-list-traverse)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates list-traverse) list-traverse))
  (import (only (euphrates range) range))
  (import
    (only (scheme base)
          <
          begin
          cond-expand
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
