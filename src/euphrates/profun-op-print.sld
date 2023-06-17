
(define-library
  (euphrates profun-op-print)
  (export profun-op-print)
  (import
    (only (euphrates bool-to-profun-result)
          bool->profun-result))
  (import (only (euphrates dprintln) dprintln))
  (import
    (only (euphrates profun-op-lambda)
          profun-op-lambda))
  (import
    (only (scheme base)
          and
          apply
          begin
          define
          not
          null?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-print.scm")))
    (else (include "profun-op-print.scm"))))
