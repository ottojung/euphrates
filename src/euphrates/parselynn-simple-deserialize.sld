
(define-library
  (euphrates parselynn-simple-deserialize)
  (export parselynn:simple:deserialize)
  (import
    (only (euphrates parselynn-core-deserialize)
          parselynn:core:deserialize))
  (import
    (only (euphrates parselynn-simple-struct)
          make-parselynn:simple:struct))
  (import
    (only (euphrates zoreslava)
          zoreslava:eval
          zoreslava:ref))
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-deserialize.scm")))
    (else (include "parselynn-simple-deserialize.scm"))))
