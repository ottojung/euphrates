
(define-library
  (euphrates read-string-file)
  (export read-string-file)
  (import
    (only (euphrates call-with-output-string)
          call-with-output-string))
  (import
    (only (scheme base)
          begin
          define
          eof-object?
          lambda
          let
          read-string
          unless))
  (import
    (only (scheme file) call-with-input-file))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/read-string-file.scm")))
    (else (include "read-string-file.scm"))))
