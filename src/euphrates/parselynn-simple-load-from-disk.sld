
(define-library
  (euphrates parselynn-simple-load-from-disk)
  (export parselynn:simple:load-from-disk)
  (import
    (only (euphrates parselynn-simple-deserialize-lists)
          parselynn:simple:deserialize/lists))
  (import (only (scheme base) begin define quote))
  (import (only (scheme eval) environment))
  (import (only (scheme load) load))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-load-from-disk.scm")))
    (else (include "parselynn-simple-load-from-disk.scm"))))
