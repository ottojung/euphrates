
(define-library
  (euphrates parselynn-simple-deserialize)
  (export parselynn:simple:deserialize)
  (import (only (euphrates fn-cons) fn-cons))
  (import (only (euphrates hashset) list->hashset))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates parselynn-core-deserialize)
          parselynn:core:deserialize))
  (import
    (only (euphrates parselynn-get-compilation-environment)
          parselynn:get-compilation-environment))
  (import
    (only (euphrates parselynn-simple-struct)
          make-parselynn:simple:struct))
  (import
    (only (euphrates zoreslava-loading-environment-p)
          zoreslava:loading-environment/p))
  (import
    (only (euphrates zoreslava)
          zoreslava:eval
          zoreslava:ref
          zoreslava?))
  (import
    (only (scheme base)
          begin
          define
          if
          map
          parameterize
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-deserialize.scm")))
    (else (include "parselynn-simple-deserialize.scm"))))
