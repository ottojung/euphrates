
(define-library
  (euphrates parselynn-folexer-struct)
  (export
    make-parselynn:folexer-struct
    parselynn:folexer?
    parselynn:folexer:additional-grammar-rules
    parselynn:folexer:base-model)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-folexer-struct.scm")))
    (else (include "parselynn-folexer-struct.scm"))))
