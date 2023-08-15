
(define-library
  (euphrates pretty-print)
  (export pretty-print)
  (import
    (only (scheme base) begin cond-expand define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import
             (rename
               (ice-9 pretty-print)
               (pretty-print ice-9-pretty-print)))
           (begin
             (include-from-path "euphrates/pretty-print.scm")))
    (else (include "pretty-print.scm"))))
