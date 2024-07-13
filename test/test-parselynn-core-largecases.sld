
(define-library
  (test-parselynn-core-largecases)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import (only (euphrates const) const))
  (import (only (euphrates ignore) ignore))
  (import
    (only (euphrates parselynn-core-conflict-handler-p)
          parselynn:core:conflict-handler/p))
  (import
    (only (euphrates parselynn-core) parselynn:core))
  (import
    (only (euphrates parselynn-run-with-error-handler)
          parselynn-run/with-error-handler))
  (import
    (only (euphrates parselynn-run) parselynn-run))
  (import
    (only (euphrates parselynn-token)
          parselynn:token:make
          parselynn:token:value))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates source-location)
          make-source-location))
  (import (only (euphrates stringf) stringf))
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
          <
          =
          >
          and
          apply
          begin
          car
          cdr
          char=?
          char?
          cond
          cons
          define
          else
          eof-object?
          equal?
          if
          lambda
          let
          let*
          letrec
          list
          modulo
          null?
          or
          parameterize
          peek-char
          procedure?
          quasiquote
          quote
          read-char
          reverse
          set!
          string
          string->number
          unless
          unquote
          vector-length
          vector-ref
          when))
  (import
    (only (scheme char)
          char-alphabetic?
          char-numeric?
          char-whitespace?))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-parselynn-core-largecases.scm")))
    (else (include "test-parselynn-core-largecases.scm"))))
