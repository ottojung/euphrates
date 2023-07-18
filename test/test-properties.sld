
(define-library
  (test-properties)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates box) box-ref box-set! make-box))
  (import
    (only (euphrates catchu-case) catchu-case))
  (import
    (only (euphrates properties)
          define-property
          define-provider
          get-property
          property-evaluatable?
          set-property!
          unset-property!
          with-properties))
  (import
    (only (scheme base)
          *
          +
          -
          /
          <
          >
          _
          begin
          cond-expand
          define
          exact
          expt
          if
          lambda
          let
          not
          quote
          round
          set!
          values))
  (import (only (scheme inexact) sqrt))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-properties.scm")))
    (else (include "test-properties.scm"))))
