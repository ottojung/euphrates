
(define-library
  (euphrates write-string-file)
  (export write-string-file)
  (import
    (only (euphrates open-file-port) open-file-port)
    (only (scheme base) begin close-port define let*)
    (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/write-string-file.scm")))
    (else (include "write-string-file.scm"))))
