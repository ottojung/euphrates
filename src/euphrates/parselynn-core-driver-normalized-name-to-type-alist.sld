
(define-library
  (euphrates
    parselynn-core-driver-normalized-name-to-type-alist)
  (export
    parselynn:core:driver-normalized-name->type/alist)
  (import
    (only (scheme base) begin define quasiquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-core-driver-normalized-name-to-type-alist.scm")))
    (else (include
            "parselynn-core-driver-normalized-name-to-type-alist.scm"))))
