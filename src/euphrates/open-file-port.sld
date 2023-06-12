
(define-library
  (euphrates open-file-port)
  (export open-file-port)
  (import
    (only (euphrates raisu) raisu)
    (only (scheme base)
          append
          begin
          cond-expand
          define
          if
          member
          quasiquote
          quote
          unquote)
    (only (scheme file)
          open-input-file
          open-output-file))
  (cond-expand
    (guile (import (only (guile) include-from-path open-file))
           (begin
             (include-from-path
               "euphrates/open-file-port.scm")))
    (else (include "open-file-port.scm"))))
