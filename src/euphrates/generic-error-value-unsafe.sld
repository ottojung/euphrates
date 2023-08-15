
(define-library
  (euphrates generic-error-value-unsafe)
  (export generic-error:value/unsafe)
  (import (only (euphrates hashmap) hashmap-ref))
  (import (only (euphrates list-last) list-last))
  (import
    (only (scheme base)
          _
          begin
          define
          define-syntax
          error-object-irritants
          let
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/generic-error-value-unsafe.scm")))
    (else (include "generic-error-value-unsafe.scm"))))
