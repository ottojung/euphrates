
(define-library
  (test-properties)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates catchu-case) catchu-case))
  (import
    (only (euphrates properties)
          define-property
          define-provider
          get-property
          set-property!
          with-properties))
  (import
    (only (scheme base)
          -
          <
          >
          begin
          define
          if
          lambda
          let
          quote
          set!))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-properties.scm")))
    (else (include "test-properties.scm"))))
