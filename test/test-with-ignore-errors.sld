
(define-library
  (test-with-ignore-errors)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates string-to-words) string->words))
  (import
    (only (euphrates with-ignore-errors)
          with-ignore-errors!))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (scheme base)
          begin
          cadr
          cond-expand
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
