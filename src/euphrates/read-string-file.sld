
(define-library
  (euphrates read-string-file)
  (export read-string-file)
  (import
    (only (euphrates open-file-port) open-file-port)
    (only (euphrates read-all-port) read-all-port)
    (only (scheme base)
          begin
          close-port
          define
          let*
          read-char))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/read-string-file.scm")))
    (else (include "read-string-file.scm"))))
