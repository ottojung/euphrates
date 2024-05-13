
(define-library
  (euphrates file-copy)
  (export file-copy)
  (import
    (only (scheme base)
          >
          and
          begin
          define
          eof-object?
          lambda
          let
          make-bytevector
          read-bytevector!
          unless
          when
          write-bytevector))
  (import
    (only (scheme file)
          call-with-input-file
          call-with-output-file))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/file-copy.scm")))
    (else (include "file-copy.scm"))))
