
(define-library
  (euphrates parselynn-core-conflict-handler-p)
  (export parselynn:core:conflict-handler/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-core-conflict-handler-p.scm")))
    (else (include "parselynn-core-conflict-handler-p.scm"))))
