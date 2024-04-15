
(define-library
  (euphrates parselynn-folexer-result-struct)
  (export
    make-parselynn:folexer-result-struct
    parselynn:folexer-result-struct?
    parselynn:folexer-result-struct:lexer
    parselynn:folexer-result-struct:input-type
    parselynn:folexer-result-struct:input)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-folexer-result-struct.scm")))
    (else (include "parselynn-folexer-result-struct.scm"))))
