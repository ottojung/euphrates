
(define-library
  (test-parselynn-core-output)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates parselynn-core-deserialize)
          parselynn:core:deserialize))
  (import
    (only (euphrates parselynn-core-diff)
          parselynn:core:diff))
  (import
    (only (euphrates parselynn-core-serialize)
          parselynn:core:serialize))
  (import
    (only (euphrates parselynn-core) parselynn:core))
  (import
    (only (euphrates zoreslava)
          zoreslava:deserialize
          zoreslava?))
  (import
    (only (scheme base)
          *
          +
          -
          /
          <
          =
          begin
          car
          define
          get-output-string
          let
          list?
          map
          open-output-string
          quasiquote
          quote
          set!
          string-length
          string?
          unquote))
  (cond-expand
    (guile (import (only (srfi srfi-1) delete)))
    (else (import (only (srfi 1) delete))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-parselynn-core-output.scm")))
    (else (include "test-parselynn-core-output.scm"))))
