
(define-library
  (euphrates file-mtime)
  (export file-mtime)
  (import
    (only (scheme base) begin cond-expand define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (only (guile) stat:mtime stat))
           (begin
             (include-from-path "euphrates/file-mtime.scm")))
    (else (include "file-mtime.scm"))))
