
(define-library
  (euphrates words-to-string)
  (export words->string)
  (import (only (euphrates negate) negate))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import
             (only (srfi srfi-13) string-join string-null?)))
    (else (import
            (only (srfi 13) string-join string-null?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/words-to-string.scm")))
    (else (include "words-to-string.scm"))))
