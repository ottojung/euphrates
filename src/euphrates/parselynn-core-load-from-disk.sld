
(define-library
  (euphrates parselynn-core-load-from-disk)
  (export parselynn:core:load-from-disk)
  (import
    (only (euphrates parselynn-core-deserialize-lists)
          parselynn:core:deserialize/lists))
  (import
    (only (euphrates parselynn-get-compilation-environment)
          parselynn:get-compilation-environment))
  (import (only (scheme base) begin define))
  (import (only (scheme load) load))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-core-load-from-disk.scm")))
    (else (include "parselynn-core-load-from-disk.scm"))))
