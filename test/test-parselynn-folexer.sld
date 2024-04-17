
(define-library
  (test-parselynn-folexer)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates parselynn-folexer-result-as-iterator)
          parselynn:folexer-result:as-iterator))
  (import
    (only (euphrates parselynn-folexer-run-on-char-port)
          parselynn:folexer:run-on-char-port))
  (import
    (only (euphrates parselynn-folexer-run-on-string)
          parselynn:folexer:run-on-string))
  (import
    (only (euphrates parselynn-folexer-struct)
          parselynn:folexer:additional-grammar-rules))
  (import
    (only (euphrates parselynn-folexer)
          make-parselynn:folexer))
  (import
    (only (euphrates parselynn-token)
          parselynn:token:category
          parselynn:token:source
          parselynn:token:value))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates source-location)
          source-location-column
          source-location-length
          source-location-line
          source-location-offset))
  (import
    (only (euphrates unique-identifier)
          with-unique-identifier-context))
  (import
    (only (euphrates with-string-as-input)
          with-string-as-input))
  (import
    (only (scheme base)
          =
          begin
          cond
          cons
          current-input-port
          define
          else
          equal?
          for-each
          if
          lambda
          length
          let
          port?
          quasiquote
          quote
          string?
          unless
          vector
          vector-length
          vector-ref
          when))
  (cond-expand
    (guile (import (only (srfi srfi-1) any)))
    (else (import (only (srfi 1) any))))
  (cond-expand
    (guile (import (only (srfi srfi-64) test-error)))
    (else (import (only (srfi 64) test-error))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-parselynn-folexer.scm")))
    (else (include "test-parselynn-folexer.scm"))))
