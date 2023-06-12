
(define-library
  (euphrates file-delete)
  (export file-delete)
  (import
    (only (euphrates catch-any) catch-any)
    (only (scheme base)
          _
          begin
          cond-expand
          define
          lambda)
    (only (scheme file) delete-file))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/file-delete.scm")))
    (else (include "file-delete.scm"))))
