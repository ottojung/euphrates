
(define-library
  (euphrates parselynn-run-with-error-handler)
  (export parselynn-run/with-error-handler)
  (import
    (only (euphrates parselynn-core-struct)
          parselynn:core:struct:actions
          parselynn:core:struct:code
          parselynn:core:struct:maybefun))
  (import
    (only (euphrates parselynn-get-compilation-environment)
          parselynn:get-compilation-environment))
  (import (only (scheme base) begin define if let))
  (import (only (scheme eval) eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-run-with-error-handler.scm")))
    (else (include "parselynn-run-with-error-handler.scm"))))
