
(define-library
  (euphrates parselynn-core-output-table-port-p)
  (export parselynn:core:output-table-port/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-core-output-table-port-p.scm")))
    (else (include
            "parselynn-core-output-table-port-p.scm"))))
