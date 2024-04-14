
(define-library
  (euphrates parselynn-fohomomorph-result-struct)
  (export
    make-parselynn/fohomomorph-result-struct
    parselynn/fohomomorph-result-struct?
    parselynn/fohomomorph-result-struct:lexer
    parselynn/fohomomorph-result-struct:input-type
    parselynn/fohomomorph-result-struct:input)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-fohomomorph-result-struct.scm")))
    (else (include
            "parselynn-fohomomorph-result-struct.scm"))))
