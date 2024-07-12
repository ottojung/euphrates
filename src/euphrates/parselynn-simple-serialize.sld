
(define-library
  (euphrates parselynn-simple-serialize)
  (export parselynn:simple:serialize)
  (import
    (only (euphrates parselynn-core-serialize)
          parselynn:core:serialize))
  (import
    (only (euphrates parselynn-simple-struct)
          parselynn:simple:struct:arguments
          parselynn:simple:struct:backend-parser
          parselynn:simple:struct:transformations))
  (import
    (only (euphrates zoreslava)
          with-zoreslava
          zoreslava:deserialize
          zoreslava:serialize
          zoreslava:set!
          zoreslava:union))
  (import
    (only (scheme base)
          begin
          define
          quasiquote
          quote
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-serialize.scm")))
    (else (include "parselynn-simple-serialize.scm"))))
