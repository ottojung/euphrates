
(define-library
  (euphrates bool-to-profun-result)
  (export bool->profun-result)
  (import
    (only (euphrates profun-accept) profun-accept)
    (only (euphrates profun-reject) profun-reject)
    (only (scheme base)
          begin
          cond
          define
          else
          equal?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bool-to-profun-result.scm")))
    (else (include "bool-to-profun-result.scm"))))
