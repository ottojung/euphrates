
(define-library
  (test-read-string-file)
  (import
    (only (euphrates append-posix-path)
          append-posix-path))
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates read-string-file)
          read-string-file))
  (import (only (scheme base) begin let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-read-string-file.scm")))
    (else (include "test-read-string-file.scm"))))
