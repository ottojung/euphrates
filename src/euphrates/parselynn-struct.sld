
(define-library
  (euphrates parselynn-struct)
  (export
    make-parselynn-struct
    parselynn-struct?
    parselynn-struct:results
    parselynn-struct:driver
    parselynn-struct:tokens
    parselynn-struct:rules
    parselynn-struct:actions
    parselynn-struct:code
    parselynn-struct:maybefun)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-struct.scm")))
    (else (include "parselynn-struct.scm"))))
