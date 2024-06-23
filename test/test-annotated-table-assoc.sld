
(define-library
  (test-annotated-table-assoc)
  (import
    (only (euphrates annotated-table-assoc)
          annotated-table-assoc))
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-annotated-table-assoc.scm")))
    (else (include "test-annotated-table-assoc.scm"))))
