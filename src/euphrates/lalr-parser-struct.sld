
(define-library
  (euphrates lalr-parser-struct)
  (export
    make-lalr-parser-struct
    lalr-parser-struct?
    lalr-parser-struct:results
    lalr-parser-struct:driver
    lalr-parser-struct:tokens
    lalr-parser-struct:rules
    lalr-parser-struct:actions
    lalr-parser-struct:code)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-parser-struct.scm")))
    (else (include "lalr-parser-struct.scm"))))
