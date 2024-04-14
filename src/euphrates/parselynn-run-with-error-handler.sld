
(define-library
  (euphrates parselynn-run-with-error-handler)
  (export parselynn-run/with-error-handler)
  (import
    (only (euphrates labelinglogic-interpret-r7rs-code)
          labelinglogic:interpret-r7rs-code))
  (import
    (only (euphrates parselynn-struct)
          parselynn-struct:actions
          parselynn-struct:code
          parselynn-struct:maybefun))
  (import (only (scheme base) begin define if let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-run-with-error-handler.scm")))
    (else (include "parselynn-run-with-error-handler.scm"))))
