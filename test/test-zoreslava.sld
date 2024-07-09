
(define-library
  (test-zoreslava)
  (import
    (only (euphrates append-posix-path)
          append-posix-path))
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates call-with-input-string)
          call-with-input-string))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (euphrates zoreslava)
          with-zoreslava
          zoreslava/p
          zoreslava:deserialize
          zoreslava:equal?
          zoreslava:eval
          zoreslava:has?
          zoreslava:load
          zoreslava:read
          zoreslava:ref
          zoreslava:serialize
          zoreslava:set!
          zoreslava:write))
  (import
    (only (scheme base)
          *
          +
          begin
          define
          for-each
          lambda
          let
          list
          not
          number->string
          procedure?
          quote
          string->symbol
          unless))
  (import
    (only (scheme file) call-with-output-file))
  (cond-expand
    (guile (import (only (srfi srfi-1) iota)))
    (else (import (only (srfi 1) iota))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-zoreslava.scm")))
    (else (include "test-zoreslava.scm"))))
