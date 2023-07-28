
(define-library
  (test-seconds-to-string-columned)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates seconds-to-string-columned)
          seconds->string-columned))
  (import
    (only (scheme base)
          *
          +
          begin
          cond-expand
          else
          not))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-seconds-to-string-columned.scm")))
    (else (include "test-seconds-to-string-columned.scm"))))
