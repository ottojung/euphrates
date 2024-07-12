
(define-library
  (euphrates parselynn-core-deserialize)
  (export parselynn:core:deserialize)
  (import
    (only (euphrates parselynn-core-struct)
          make-parselynn:core:struct))
  (import
    (only (euphrates zoreslava)
          zoreslava:deserialize/lists
          zoreslava:ref))
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-core-deserialize.scm")))
    (else (include "parselynn-core-deserialize.scm"))))
