
(define-library
  (euphrates with-lalr-parser-conflict-handler)
  (export with-lalr-parser-conflict-handler)
  (import
    (only (euphrates lalr-parser-conflict-handler-p)
          lalr-parser-conflict-handler/p))
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          let
          parameterize
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/with-lalr-parser-conflict-handler.scm")))
    (else (include "with-lalr-parser-conflict-handler.scm"))))
