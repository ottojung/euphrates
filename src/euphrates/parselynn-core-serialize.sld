
(define-library
  (euphrates parselynn-core-serialize)
  (export parselynn:core:serialize)
  (import
    (only (euphrates parselynn-core-serialized-typetag)
          parselynn:core:serialized-typetag))
  (import
    (only (euphrates parselynn-core-struct)
          parselynn:core:struct:actions
          parselynn:core:struct:code
          parselynn:core:struct:driver
          parselynn:core:struct:results
          parselynn:core:struct:rules
          parselynn:core:struct:tokens))
  (import
    (only (scheme base)
          begin
          define
          let
          quasiquote
          quote
          unquote
          vector))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-core-serialize.scm")))
    (else (include "parselynn-core-serialize.scm"))))
