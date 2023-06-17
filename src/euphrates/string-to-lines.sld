
(define-library
  (euphrates string-to-lines)
  (export string->lines)
  (import
    (only (euphrates string-split-simple)
          string-split/simple))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/string-to-lines.scm")))
    (else (include "string-to-lines.scm"))))
