
(define-library
  (test-parselynn-calc)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates parselynn-run-with-error-handler)
          parselynn-run/with-error-handler))
  (import
    (only (euphrates parselynn)
          parselynn
          lexical-token-category
          lexical-token-source
          lexical-token-value
          lexical-token?
          make-lexical-token))
  (import
    (only (euphrates source-location)
          make-source-location
          source-location-column
          source-location-line
          source-location?))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (euphrates with-string-as-input)
          with-string-as-input))
  (import
    (only (scheme base)
          *
          +
          -
          /
          =
          and
          apply
          assq
          begin
          call-with-current-continuation
          car
          cdr
          char=?
          cond
          cons
          current-input-port
          define
          else
          eof-object?
          error
          expt
          for-each
          if
          lambda
          let
          let*
          letrec
          list
          newline
          not
          number?
          or
          pair?
          peek-char
          procedure?
          quasiquote
          quote
          read-char
          reverse
          set!
          set-cdr!
          string
          string->number
          string->symbol
          unquote))
  (import
    (only (scheme char)
          char-alphabetic?
          char-numeric?))
  (import (only (scheme inexact) cos sin sqrt tan))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-parselynn-calc.scm")))
    (else (include "test-parselynn-calc.scm"))))
