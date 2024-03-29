
(define-library
  (euphrates path-get-basename)
  (export path-get-basename)
  (import (only (euphrates list-last) list-last))
  (import
    (only (euphrates string-split-simple)
          string-split/simple))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/path-get-basename.scm")))
    (else (include "path-get-basename.scm"))))
