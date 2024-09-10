
(define-library
  (benchmark-parselynn-core)
  (import
    (only (data parser-branching-glr)
          parser-branching-glr))
  (import
    (only (data parser-branching-lr-1)
          parser-branching-lr-1))
  (import
    (only (data parser-branching-lr)
          parser-branching-lr))
  (import
    (only (data parser-repeating-glr)
          parser-repeating-glr))
  (import
    (only (data parser-repeating-lr-1)
          parser-repeating-lr-1))
  (import
    (only (data parser-repeating-lr)
          parser-repeating-lr))
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import (only (euphrates ignore) ignore))
  (import
    (only (euphrates parselynn-core-conflict-handler-p)
          parselynn:core:conflict-handler/p))
  (import
    (only (euphrates parselynn-core-deserialize-lists)
          parselynn:core:deserialize/lists))
  (import
    (only (euphrates parselynn-core) parselynn:core))
  (import
    (only (euphrates parselynn-run) parselynn-run))
  (import
    (only (euphrates parselynn-token)
          parselynn:token:make))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates un-tilda-s) un~s))
  (import
    (only (euphrates with-benchmark-simple)
          with-benchmark/simple
          with-benchmark/timestamp))
  (import
    (only (scheme base)
          *
          +
          -
          /
          <
          =
          >
          _
          begin
          car
          cdr
          cond
          define
          else
          equal?
          even?
          if
          lambda
          let
          list
          member
          modulo
          null?
          parameterize
          procedure?
          quasiquote
          quote
          set!
          unquote
          vector-length
          vector-ref
          when))
  (cond-expand
    (guile (import (only (srfi srfi-1) first)))
    (else (import (only (srfi 1) first))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "benchmark-parselynn-core.scm")))
    (else (include "benchmark-parselynn-core.scm"))))
