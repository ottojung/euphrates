
(define-library
  (euphrates tilda-s)
  (export ~s)
  (import
    (only (euphrates stringf) stringf)
    (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/tilda-s.scm")))
    (else (include "tilda-s.scm"))))
