
(define-library
  (test-parselynn-output-precise)
  (import (only (euphrates assert) assert))
  (import (only (euphrates comp) comp))
  (import (only (euphrates ignore) ignore))
  (import
    (only (euphrates parselynn) parselynn))
  (import (only (euphrates printf) printf))
  (import (only (euphrates read-list) read-list))
  (import
    (only (euphrates stack)
          stack->list
          stack-empty?
          stack-make
          stack-push!))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          *
          +
          -
          /
          =
          begin
          cons
          define
          equal?
          for-each
          if
          lambda
          let
          newline
          quasiquote
          quote
          string->symbol
          unless
          unquote))
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
               "test-parselynn-output-precise.scm")))
    (else (include "test-parselynn-output-precise.scm"))))
