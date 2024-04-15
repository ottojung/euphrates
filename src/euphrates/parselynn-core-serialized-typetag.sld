
(define-library
  (euphrates parselynn-core-serialized-typetag)
  (export parselynn:core:serialized-typetag)
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-core-serialized-typetag.scm")))
    (else (include "parselynn-core-serialized-typetag.scm"))))
