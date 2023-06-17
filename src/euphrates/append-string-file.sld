
(define-library
  (euphrates append-string-file)
  (export append-string-file)
  (import
    (only (euphrates open-file-port) open-file-port))
  (import
    (only (scheme base) begin close-port define let*))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/append-string-file.scm")))
    (else (include "append-string-file.scm"))))
