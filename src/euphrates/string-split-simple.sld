
(define-library
  (euphrates string-split-simple)
  (export string-split/simple)
  (import (only (euphrates irregex) irregex-split))
  (import
    (only (scheme base)
          begin
          char?
          cond
          define
          else
          error
          list
          string?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (only (guile) string-split))
           (begin
             (include-from-path
               "euphrates/string-split-simple.scm")))
    (else (include "string-split-simple.scm"))))
