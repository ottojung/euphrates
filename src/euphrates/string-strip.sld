
(define-library
  (euphrates string-strip)
  (export string-strip)
  (import
    (only (euphrates string-trim-chars)
          string-trim-chars)
    (only (scheme base) begin define quote)
    (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/string-strip.scm")))
    (else (include "string-strip.scm"))))
