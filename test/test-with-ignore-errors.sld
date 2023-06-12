
(define-library
  (test-with-ignore-errors)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates raisu) raisu)
    (only (euphrates string-to-words) string->words)
    (only (euphrates with-ignore-errors)
          with-ignore-errors!)
    (only (euphrates with-output-to-string)
          with-output-to-string)
    (only (scheme base)
          begin
          cadr
          current-error-port
          current-output-port
          let
          parameterize
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-with-ignore-errors.scm")))
    (else (include "test-with-ignore-errors.scm"))))
