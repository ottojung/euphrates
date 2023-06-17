
(define-library
  (euphrates un-tilda-s)
  (export un~s)
  (import
    (only (euphrates call-with-input-string)
          call-with-input-string))
  (import
    (only (scheme base)
          begin
          close-port
          cond-expand
          define
          lambda
          let))
  (import (only (scheme read) read))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/un-tilda-s.scm")))
    (else (include "un-tilda-s.scm"))))
