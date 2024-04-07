
(define-library
  (euphrates parselynn-singlechar-struct)
  (export
    make-parselynn/singlechar-struct
    parselynn/singlechar?
    parselynn/singlechar:additional-grammar-rules
    parselynn/singlechar:lexer-model)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-singlechar-struct.scm")))
    (else (include "parselynn-singlechar-struct.scm"))))
