
(define-library
  (euphrates path-get-dirname)
  (export path-get-dirname)
  (import
    (only (euphrates get-directory-name)
          get-directory-name))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/path-get-dirname.scm")))
    (else (include "path-get-dirname.scm"))))
