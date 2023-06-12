
(define-library
  (euphrates profune-communications-hook-p)
  (export profune-communications-hook/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profune-communications-hook-p.scm")))
    (else (include "profune-communications-hook-p.scm"))))
