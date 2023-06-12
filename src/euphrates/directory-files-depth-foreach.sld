
(define-library
  (euphrates directory-files-depth-foreach)
  (export directory-files-depth-foreach)
  (import
    (only (euphrates directory-files-depth-iter)
          directory-files-depth-iter)
    (only (scheme base) begin define if let when)
    (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/directory-files-depth-foreach.scm")))
    (else (include "directory-files-depth-foreach.scm"))))
