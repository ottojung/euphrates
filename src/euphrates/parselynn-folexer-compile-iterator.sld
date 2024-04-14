
(define-library
  (euphrates parselynn-folexer-compile-iterator)
  (export parselynn:folexer:compile/iterator)
  (import
    (only (euphrates
            labelinglogic-model-compile-to-r7rs-first)
          labelinglogic:model:compile-to-r7rs/first))
  (import
    (only (euphrates parselynn-folexer-struct)
          parselynn:folexer:base-model))
  (import
    (only (euphrates parselynn) make-lexical-token))
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
          or
          port?
          procedure?
          quasiquote
          quote
          read-char
          set!
          string-length
          string-ref
          string?
          unless
          unquote
          vector
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-folexer-compile-iterator.scm")))
    (else (include
            "parselynn-folexer-compile-iterator.scm"))))
