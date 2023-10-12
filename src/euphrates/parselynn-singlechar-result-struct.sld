
(define-library
  (euphrates parselynn-singlechar-result-struct)
  (export
    make-parselynn/singlechar-result-struct
    parselynn/singlechar-result-struct?
    parselynn/singlechar-result-struct:lexer
    parselynn/singlechar-result-struct:input-type
    parselynn/singlechar-result-struct:input)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-singlechar-result-struct.scm")))
    (else (include
            "parselynn-singlechar-result-struct.scm"))))
