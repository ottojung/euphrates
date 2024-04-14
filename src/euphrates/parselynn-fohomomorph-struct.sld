
(define-library
  (euphrates parselynn-fohomomorph-struct)
  (export
    make-parselynn:fohomomorph-struct
    parselynn:fohomomorph?
    parselynn:fohomomorph:additional-grammar-rules
    parselynn:fohomomorph:lexer-model)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-fohomomorph-struct.scm")))
    (else (include "parselynn-fohomomorph-struct.scm"))))
