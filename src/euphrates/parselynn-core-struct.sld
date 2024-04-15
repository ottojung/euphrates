
(define-library
  (euphrates parselynn-core-struct)
  (export
    make-parselynn:core:struct
    parselynn:core:struct?
    parselynn:core:struct:results
    parselynn:core:struct:driver
    parselynn:core:struct:tokens
    parselynn:core:struct:rules
    parselynn:core:struct:actions
    parselynn:core:struct:code
    parselynn:core:struct:maybefun)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-core-struct.scm")))
    (else (include "parselynn-core-struct.scm"))))
