
(define-library
  (test-string->words)
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
             (include-from-path "test-string-to-words.scm")))
    (else (include "test-string-to-words.scm"))))
