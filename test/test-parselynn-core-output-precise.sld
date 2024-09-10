
(define-library
  (test-parselynn-core-output-precise)
  (import (only (euphrates assert) assert))
  (import (only (euphrates ignore) ignore))
  (import
    (only (euphrates parselynn-core-conflict-handler-p)
          parselynn:core:conflict-handler/p))
  (import
    (only (euphrates parselynn-core-serialize)
          parselynn:core:serialize))
  (import
    (only (euphrates parselynn-core) parselynn:core))
  (import (only (euphrates printf) printf))
  (import (only (euphrates read-list) read-list))
  (import
    (only (euphrates stack)
          stack->list
          stack-empty?
          stack-make
          stack-push!))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates un-tilda-s) un~s))
  (import
    (only (scheme base)
          *
          +
          -
          /
          =
          begin
          define
          equal?
          for-each
          if
          lambda
          let
          list
          map
          newline
          parameterize
          quasiquote
          quote
          string->symbol
          unless
          unquote
          unquote-splicing))
  (import
    (only (scheme file)
          call-with-input-file
          call-with-output-file
          file-exists?))
  (import (only (scheme write) write))
  (cond-expand
    (guile (import (only (srfi srfi-1) first)))
    (else (import (only (srfi 1) first))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-parselynn-core-output-precise.scm")))
    (else (include
            "test-parselynn-core-output-precise.scm"))))
