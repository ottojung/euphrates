
(define-library
  (euphrates parselynn-core-deserialize)
  (export parselynn:core:deserialize)
  (import
    (only (euphrates parselynn-core-struct)
          make-parselynn:core:struct))
  (import
    (only (euphrates zoreslava)
          zoreslava:eval
          zoreslava:ref
          zoreslava?))
  (import
    (only (scheme base) begin define if quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-core-deserialize.scm")))
    (else (include "parselynn-core-deserialize.scm"))))
