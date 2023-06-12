
(define-library
  (test-string->words)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates string-to-words) string->words)
    (only (euphrates words-to-string) words->string)
    (only (scheme base) begin list))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-string->words.scm")))
    (else (include "test-string->words.scm"))))
