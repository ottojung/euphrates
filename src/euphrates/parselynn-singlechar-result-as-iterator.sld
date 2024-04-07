
(define-library
  (euphrates
    parselynn-singlechar-result-as-iterator)
  (export parselynn/singlechar-result:as-iterator)
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates labelinglogic-model-evaluate-first)
          labelinglogic:model:evaluate/first))
  (import
    (only (euphrates parselynn-singlechar-result-struct)
          parselynn/singlechar-result-struct:input
          parselynn/singlechar-result-struct:input-type
          parselynn/singlechar-result-struct:lexer))
  (import
    (only (euphrates parselynn-singlechar-struct)
          parselynn/singlechar:lexer-model))
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
               "euphrates/parselynn-singlechar-result-as-iterator.scm")))
    (else (include
            "parselynn-singlechar-result-as-iterator.scm"))))
