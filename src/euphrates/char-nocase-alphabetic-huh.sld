
(define-library
  (euphrates char-nocase-alphabetic-huh)
  (export char-nocase-alphabetic?)
  (import
    (only (scheme base) and begin define not))
  (import
    (only (scheme char)
          char-alphabetic?
          char-lower-case?
          char-upper-case?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/char-nocase-alphabetic-huh.scm")))
    (else (include "char-nocase-alphabetic-huh.scm"))))
