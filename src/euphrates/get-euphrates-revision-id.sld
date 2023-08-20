
(define-library
  (euphrates get-euphrates-revision-id)
  (export get-euphrates-revision-id)
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates system-environment)
          system-environment-get))
  (import
    (only (scheme base) begin define list or quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/get-euphrates-revision-id.scm")))
    (else (include "get-euphrates-revision-id.scm"))))
