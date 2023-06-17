
(define-library
  (euphrates usymbol)
  (export
    make-usymbol
    usymbol?
    usymbol-name
    usymbol-qualifier)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/usymbol.scm")))
    (else (include "usymbol.scm"))))
