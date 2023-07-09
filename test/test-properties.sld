
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
          *
          +
          -
          /
          <
          >
          _
          begin
          define
          exact
          expt
          if
          lambda
          let
          quote
          round
          set!
          values))
  (import (only (scheme inexact) sqrt))
  (cond-expand
    (guile (import (only (srfi srfi-1) count)))
    (else (import (only (srfi 1) count))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-properties.scm")))
    (else (include "test-properties.scm"))))
