
(define-library
  (euphrates profun-meta-key)
  (export profun-meta-key)
  (import
    (only (euphrates usymbol) make-usymbol)
    (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-meta-key.scm")))
    (else (include "profun-meta-key.scm"))))
