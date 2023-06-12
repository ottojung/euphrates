
(define-library
  (euphrates path-without-extension)
  (export path-without-extension)
  (import
    (only (srfi srfi-13)
          string-index-right
          string-take)
    (only (scheme base) begin define if let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/path-without-extension.scm")))
    (else (include "path-without-extension.scm"))))
