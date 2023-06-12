
(define-library
  (test-file-or-directory-exists?)
  (import
    (only (euphrates append-posix-path)
          append-posix-path)
    (only (euphrates assert) assert)
    (only (euphrates file-or-directory-exists-q)
          file-or-directory-exists?)
    (only (scheme base) begin let not))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-file-or-directory-exists?.scm")))
    (else (include "test-file-or-directory-exists?.scm"))))
