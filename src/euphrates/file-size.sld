
(define-library
  (euphrates file-size)
  (export file-size)
  (import
    (only (scheme base) begin cond-expand define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (only (guile) stat stat:size))
           (begin
             (include-from-path "euphrates/file-size.scm")))
    (else (include "file-size.scm"))))
