
(define-library
  (test-words->string)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates string-to-words) string->words))
  (import
    (only (euphrates words-to-string) words->string))
  (import
    (only (scheme base) begin cond-expand list not))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-words-to-string.scm")))
    (else (include "test-words-to-string.scm"))))
