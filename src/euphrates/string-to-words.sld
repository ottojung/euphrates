
(define-library
  (euphrates string-to-words)
  (export string->words)
  (import
    (only (scheme base) begin cond-expand define))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-tokenize)))
    (else (import (only (srfi 13) string-tokenize))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/string-to-words.scm")))
    (else (include "string-to-words.scm"))))
