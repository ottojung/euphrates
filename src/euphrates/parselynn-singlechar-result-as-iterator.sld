
(define-library
  (euphrates
    parselynn-singlechar-result-as-iterator)
  (export parselynn/singlechar-result:as-iterator)
  (import (only (euphrates hashmap) hashmap-ref))
  (import
    (only (euphrates
            labelinglogic-make-nondet-descriminator)
          labelinglogic:make-nondet-descriminator))
  (import
    (only (euphrates parselynn-singlechar-result-struct)
          parselynn/singlechar-result-struct:input
          parselynn/singlechar-result-struct:input-type
          parselynn/singlechar-result-struct:lexer))
  (import
    (only (euphrates parselynn-singlechar-struct)
          parselynn/singlechar-struct:categories
          parselynn/singlechar-struct:singleton-map))
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
          and
          begin
          car
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
          not
          null?
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
