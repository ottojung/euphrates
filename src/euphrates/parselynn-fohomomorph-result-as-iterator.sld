
(define-library
  (euphrates
    parselynn-fohomomorph-result-as-iterator)
  (export parselynn:fohomomorph-result:as-iterator)
  (import
    (only (euphrates labelinglogic-interpret-r7rs-code)
          labelinglogic:interpret-r7rs-code))
  (import
    (only (euphrates
            labelinglogic-model-compile-to-r7rs-first)
          labelinglogic:model:compile-to-r7rs/first))
  (import
    (only (euphrates parselynn-fohomomorph-result-struct)
          parselynn:fohomomorph-result-struct:input
          parselynn:fohomomorph-result-struct:input-type
          parselynn:fohomomorph-result-struct:lexer))
  (import
    (only (euphrates parselynn-fohomomorph-struct)
          parselynn:fohomomorph:lexer-model))
  (import
    (only (euphrates parselynn) make-lexical-token))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates source-location)
          make-source-location))
  (import
    (only (scheme base)
          +
          >=
          _
          begin
          cond
          define
          else
          eof-object
          eof-object?
          equal?
          if
          lambda
          let
          list
          or
          port?
          quote
          read-char
          set!
          string
          string-length
          string-ref
          string?
          unless
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-fohomomorph-result-as-iterator.scm")))
    (else (include
            "parselynn-fohomomorph-result-as-iterator.scm"))))
