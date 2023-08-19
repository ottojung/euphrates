
(define-library
  (euphrates with-run-time-estimate)
  (export with-run-time-estimate)
  (import
    (only (scheme base)
          -
          /
          _
          begin
          define
          define-syntax
          let
          syntax-rules))
  (import (only (scheme r5rs) exact->inexact))
  (import
    (only (scheme time)
          current-jiffy
          jiffies-per-second))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/with-run-time-estimate.scm")))
    (else (include "with-run-time-estimate.scm"))))
