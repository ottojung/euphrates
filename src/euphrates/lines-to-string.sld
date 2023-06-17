
(define-library
  (euphrates lines-to-string)
  (export lines->string)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-join)))
    (else (import (only (srfi 13) string-join))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lines-to-string.scm")))
    (else (include "lines-to-string.scm"))))
