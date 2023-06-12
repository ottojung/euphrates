
(define-library
  (euphrates syntax-tree-foreach)
  (export syntax-tree-foreach)
  (import
    (only (scheme base)
          ...
          _
          begin
          define-syntax
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/syntax-tree-foreach.scm")))
    (else (include "syntax-tree-foreach.scm"))))
