
(define-library
  (euphrates profun-eval-query-terms)
  (export profun-eval-query/terms)
  (import
    (only (euphrates profun-next-term-group)
          profun-next/term-group))
  (import
    (only (euphrates profun)
          profun-eval-from/generic
          profun-iterate))
  (import
    (only (scheme base)
          _
          append
          apply
          begin
          cond-expand
          define
          lambda
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-eval-query-terms.scm")))
    (else (include "profun-eval-query-terms.scm"))))
