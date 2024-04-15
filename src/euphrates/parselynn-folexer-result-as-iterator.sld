
(define-library
  (euphrates
    parselynn-folexer-result-as-iterator)
  (export parselynn:folexer-result:as-iterator)
  (import
    (only (euphrates labelinglogic-interpret-r7rs-code)
          labelinglogic:interpret-r7rs-code))
  (import
    (only (euphrates
            labelinglogic-model-compile-to-r7rs-first)
          labelinglogic:model:compile-to-r7rs/first))
  (import
    (only (euphrates parselynn-folexer-result-struct)
          parselynn:folexer-result-struct:input
          parselynn:folexer-result-struct:input-type
          parselynn:folexer-result-struct:lexer))
  (import
    (only (euphrates parselynn-folexer-struct)
          parselynn:folexer:base-model))
  (import
    (only (euphrates parselynn-core) make-lexical-token))
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
               "euphrates/parselynn-folexer-result-as-iterator.scm")))
    (else (include
            "parselynn-folexer-result-as-iterator.scm"))))
