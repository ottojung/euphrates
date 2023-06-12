
(define-library
  (euphrates lexical-scope-obj)
  (export
    lexical-scope-wrap
    lexical-scope?
    lexical-scope-unwrap)
  (import
    (only (euphrates define-newtype) define-newtype)
    (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lexical-scope-obj.scm")))
    (else (include "lexical-scope-obj.scm"))))
