
(define-library
  (euphrates path-without-extensions)
  (export path-without-extensions)
  (import (only (scheme base) begin define if let))
  (cond-expand
    (guile (import
             (only (srfi srfi-13) string-index string-take)))
    (else (import
            (only (srfi 13) string-index string-take))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/path-without-extensions.scm")))
    (else (include "path-without-extensions.scm"))))
