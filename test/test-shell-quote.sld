
(define-library
  (test-shell-quote)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates shell-quote) shell-quote)
    (only (scheme base) begin let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-shell-quote.scm")))
    (else (include "test-shell-quote.scm"))))
