
(define-library
  (euphrates file-or-directory-exists-q)
  (export file-or-directory-exists?)
  (import
    (only (scheme base) begin cond-expand define or))
  (import (only (scheme file) file-exists?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/file-or-directory-exists-q.scm")))
    (else (include "file-or-directory-exists-q.scm"))))
